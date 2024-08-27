<template>
    <div>
        <v-expansion-panels variant="accordion">
            <v-expansion-panel v-for="subject in subjects">
                <v-expansion-panel-title>{{ subject.subject_no }} - {{ subject.subject_name }}</v-expansion-panel-title>
                <v-expansion-panel-text>
                    <v-expansion-panels variant="accordion">
                        <v-expansion-panel>
                            <v-expansion-panel-title>Student List</v-expansion-panel-title>
                            <v-expansion-panel-text>
                                <v-data-table :headers="headers" :items="subject.students" :disable-pagination="true"
                                :hide-default-footer="true"></v-data-table>
                            </v-expansion-panel-text>
                        </v-expansion-panel>
                        <v-expansion-panel>
                            <v-expansion-panel-title>Schedule List</v-expansion-panel-title>
                            <v-expansion-panel-text>
                                <v-list>
                                    <v-list-item v-for="lesson in subject.lessons">
                                        <v-list-item-title @click="handleEventClick(lesson.lesson_id)">{{
                                            formatDate(convertDateToJS(lesson.lesson_start)) }} - {{
                                                formatDate(convertDateToJS(lesson.lesson_end)) }}</v-list-item-title>
                                    </v-list-item>
                                </v-list>
                            </v-expansion-panel-text>
                        </v-expansion-panel>
                    </v-expansion-panels>
                </v-expansion-panel-text>
            </v-expansion-panel>
        </v-expansion-panels>
    </div>
    <AppMarkAttendance ref="dialog" :userId="userId" :permission="permission" />
</template>
<script>
//TO Display Staff the subject all schedule (table)
export default {
    data: () => ({
        permission: '',
        subjects: [],
        headers: [
                {
                    title: 'Student No',
                    align: 'start',
                    key: 'student_no',
                },
                {
                    title: 'Surname',
                    align: 'start',
                    key: 'surname',
                },
                {
                    title: 'Given Name',
                    align: 'start',
                    key: 'given_name',
                },
            ],
    }),
    mounted() {
        this.fetchSchedule();
    },
    methods: {
        async fetchSchedule() {
            this.loading = true;
            const mySelf = this;
            mySelf.subjects = [];
            await CallApi(`${this.$config.public.apiBaseUrl}/auth/session`, {

            }, async (userinfo) => {
                const { id, permission } = userinfo;
                mySelf.permission = permission;
                await CallApi(`${this.$config.public.apiBaseUrl}/staff/schedule`, {
                    id: id
                }, async (response) => {
                    const subjects = response.classes.reduce((acc, curr) => {
                        const existingSubject = acc.find(g => g.subject_class_id === curr.subject_class_id);
                        if (existingSubject) {
                            existingSubject.lessons.push({ lesson_start: curr.lesson_start, lesson_end: curr.lesson_end });
                        } else {
                            acc.push({
                                subject_class_id: curr.subject_class_id,
                                subject_no: curr.subject_no,
                                subject_name: curr.subject_name,
                                lessons: [{ lesson_id: curr.subject_class_schedule_id, lesson_start: curr.lesson_start, lesson_end: curr.lesson_end }]
                            });
                        }
                        return acc;
                    }, []);
                    // mySelf.subjects = subjects;
                    await mySelf.fetchSubjectsStudents(subjects);
                    //response.classes
                }, (error) => {
                    // console.log(error);
                });
            }, (error) => {
                // console.log(error);
            });
            this.loading = false;
        },
        async fetchSubjectsStudents(subjects) {
            this.loading = true;
            const mySelf = this;
            subjects.forEach(async (item) => {
                item.students = [];
                await CallApi(`${this.$config.public.apiBaseUrl}/subject/students`, {
                    id: item.subject_class_id
                }, (response) => {
                    item.students = response.students;
                    //response.classes
                }, (error) => {
                    // console.log(error);
                });
            });
            mySelf.subjects = subjects;
            this.loading = false;
        },
        handleEventClick(lessonId) {
            this.$refs.dialog.start(lessonId);
        },
        convertDateToJS(date) {
            return new Date(date)
        },
        formatDate(date) {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            return `${day}/${month}/${year} ${hours}:${minutes}`;
        }
    },
}
</script>
<template>
    <div>
        <v-expansion-panels variant="accordion">
            <v-expansion-panel v-for="subject in subjects">
                <v-expansion-panel-title>{{ subject.subject_no }} - {{ subject.subject_name }}</v-expansion-panel-title>
                <v-expansion-panel-text>
                    <v-data-table v-model="selected" :headers="headers" :items="subject.lessons" :disable-pagination="true" :hide-default-footer="true"></v-data-table>
                </v-expansion-panel-text>
            </v-expansion-panel>
        </v-expansion-panels>
    </div>
</template>
<script>
//TO Display student the suject info (included attandance)
export default {
    data: () => ({
        userId: 0,
        permission: '',
        subjects: [],
        headers: [
            {
                title: 'Lesson Start',
                align: 'start',
                key: 'lesson_start',
            },
            {
                title: 'Lesson End',
                align: 'start',
                key: 'lesson_end',
            },
            {
                title: 'Attended',
                align: 'start',
                key: 'is_attend',
            },
        ],
    }),
    mounted() {
        this.fetchSubjects();
    },
    methods: {
        async fetchSubjects() {
            this.loading = true;
            const mySelf = this;
            mySelf.subjects = [];
            await CallApi(`${this.$config.public.apiBaseUrl}/auth/session`, {

            }, async (userinfo) => {
                const { id, permission } = userinfo;
                mySelf.userId = id;
                mySelf.permission = permission;
                await CallApi(`${this.$config.public.apiBaseUrl}/student/schedule`, {
                    id: id
                }, async (response) => {
                    const subjects = response.classes.reduce((acc, curr) => {
                        const existingSubject = acc.find(g => g.subject_id === curr.subject_id);
                        if (existingSubject) {
                            existingSubject.lessons.push({ lesson_id: curr.subject_class_id, lesson_start: mySelf.formatDate(mySelf.convertDateToJS(curr.lesson_start)), lesson_end: mySelf.formatDate(mySelf.convertDateToJS(curr.lesson_end)), is_attend: curr.is_attend });
                        } else {
                            acc.push({
                                subject_id: curr.subject_id,
                                subject_no: curr.subject_no,
                                subject_name: curr.subject_name,
                                lessons: [{ lesson_id: curr.subject_class_id, lesson_start: mySelf.formatDate(mySelf.convertDateToJS(curr.lesson_start)), lesson_end: mySelf.formatDate(mySelf.convertDateToJS(curr.lesson_end)), is_attend: curr.is_attend }]
                            });
                        }
                        return acc;
                    }, []);
                    mySelf.subjects = subjects;
                    // console.log(mySelf.subjects)
                    //response.classes
                }, (error) => {
                    // console.log(error);
                }, this);
            }, (error) => {
                // console.log(error);
            }, this);
            this.loading = false;
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
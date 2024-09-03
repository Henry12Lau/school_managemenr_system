<template>
    <v-data-table-server v-model:items-per-page="itemsPerPage" :headers="subjectHeaders" :items="serverItems"
        :items-length="totalItems" :loading="loading" :search="search" item-value="subjectNum"
        @update:options="loadItems">
        <template v-slot:top>
            <tr>
                <td>
                    <v-text-field v-model="searchText" class="ma-2" density="compact" placeholder="Search..."
                        hide-details style="width: 300px;"></v-text-field>
                </td>
            </tr>
        </template>
        <template v-slot:item.status="{ item }">
            <UBadge :label="item.status ? 'Inactive' : 'Active'" variant="subtle" class="mb-0.5"
                :color="item.status ? 'red' : 'blue'" />
        </template>
        <template v-slot:item.list="{ item }">
            <v-btn outlined color="secondary" @click="handleListButtonClick(item)">{{ item.list }}</v-btn>
        </template>
        <template v-slot:item.edit="{ item }">
            <v-btn outlined color="primary" @click="handleEditButtonClick(item)">{{ item.edit }}</v-btn>
        </template>
    </v-data-table-server>

    <!-- Dialog Component -->
    <v-dialog v-model="editDialog" max-width="500px">
        <v-card>
            <v-card-title>
                <span class="headline">Edit</span>
            </v-card-title>
            <v-card-text>
                <!-- Add your form or content here -->
                <v-text-field v-model="selectedSubject.subjectNo" label="Subject No." readonly></v-text-field>
                <v-text-field v-model="selectedSubject.SubjectName" label="Subject Name"></v-text-field>
                <v-text-field v-model="selectedSubject.numberOfLesson" label="No. Of Lesson"></v-text-field>
                <v-text-field v-model="selectedSubject.lessonDuration" label="Lesson Duration (hrs)"></v-text-field>
                <!-- Add more fields as needed -->
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="editDialog = false">Cancel</v-btn>
                <v-btn color="blue darken-1" text @click="subjectSave">Save</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    <v-dialog v-model="listDialog" max-width="1000px">
        <v-card>
            <v-card-title>
                <span class="headline">Classes List of: {{ selectedSubject.subjectNo }} - {{ selectedSubject.SubjectName
                    }}</span>
            </v-card-title>
            <v-card-text>
                <!-- Add your form or content here -->
                <v-data-table :headers="classHeaders" :items="classList" :disable-pagination="true"
                    :hide-default-footer="true">
                    <template v-slot:item.detail="{ item }">
                        <v-btn outlined color="secondary" @click="handleDetailButtonClick(item)">{{ item.detail
                            }}</v-btn>
                    </template>
                    <template v-slot:item.enroll="{ item }">
                        <v-btn outlined color="primary" @click="handleEnrollButtonClick(item)">{{ item.enroll
                            }}</v-btn>
                    </template>
                </v-data-table>
                <!-- Add more fields as needed -->
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="listDialog = false">Cancel</v-btn>
                <v-btn color="blue darken-1" text @click="handleNewClassButtonClick">New Class</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    <v-dialog v-model="classDialog" max-width="700px">
        <v-card>
            <v-card-title>
                <span class="headline">New Class: {{ selectedSubject.subjectNo }} - {{ selectedSubject.SubjectName
                    }}</span>
            </v-card-title>
            <v-card-text>
                <!-- Add your form or content here -->
                <v-row>
                    <v-select v-model="classTeacher" :items="teacherList" label="Select Teacher" item-title="full_name"
                        item-value="id"></v-select>
                </v-row>
                <v-row v-for="item in scheduleList">
                    <v-col cols="6">
                        <v-text-field v-model="item.lesson_start" label="Start: dd/MM/yyyy HH:mm"></v-text-field>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field v-model="item.lesson_end" label="End: dd/MM/yyyy HH:mm" readonly></v-text-field>
                    </v-col>
                </v-row>
                <!-- Add more fields as needed -->
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="classDialog = false">Cancel</v-btn>
                <v-btn color="blue darken-1" text @click="createNewClass" v-if="!classId">Create New Class</v-btn>
                <v-btn color="blue darken-1" text @click="saveClass" v-if="classId">Save Class</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    <v-dialog v-model="studentDialog" max-width="700px">
        <v-card>
            <v-card-title>
                <span class="headline">Enroll Student to the Class:</span>
            </v-card-title>
            <v-card-text>
                <!-- Add your form or content here -->
                <v-row>
                    <v-col cols="6" v-for="student in studentList">
                        <v-checkbox v-model="enrolledStudents" :label="student.full_name"
                            :value="student.student_id"></v-checkbox>
                    </v-col>
                </v-row>

                <!-- Add more fields as needed -->
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="studentDialog = false">Cancel</v-btn>
                <v-btn color="blue darken-1" text @click="enrollStudent">Enroll</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>

</template>

<script>
export default {
    data: () => ({
        itemsPerPage: 10,
        subjectHeaders: [
            { title: 'Subject No.', align: 'start', key: 'subjectNo' },
            { title: 'Subject Name', key: 'SubjectName', align: 'start', sortable: false },
            { title: 'No. Of Lesson', key: 'numberOfLesson', align: 'start', sortable: false },
            { title: 'Lesson Duration (hrs)', key: 'lessonDuration', align: 'start', sortable: false },
            { title: '', key: 'list', align: 'end' },
            { title: '', key: 'edit', align: 'end' },
        ],
        classHeaders: [
            { title: 'Staff No.', align: 'start', key: 'staff_no' },
            { title: 'Teacher Name', align: 'start', key: 'fullName', value: item => `${item.surname} ${item.given_name}` },
            { title: 'Subject No.', key: 'subject_no', align: 'start' },
            { title: 'Subject Name', key: 'subject_name', align: 'start' },
            { title: 'First of the lesson', key: 'lesson_start', align: 'start' },
            { title: '', key: 'detail', align: 'start' },
            { title: '', key: 'enroll', align: 'start' },
        ],
        serverItems: [],
        loading: true,
        totalItems: 0,
        searchText: '',
        search: '',
        subjectList: [],
        classList: [],
        scheduleList: [],
        listDialog: false,
        classDialog: false,
        editDialog: false,
        studentDialog: false,
        selectedSubject: {},
        classId: null,
        classTeacher: '',
        enrolledStudents: [],
        studentList: [],
    }),
    watch: {
        searchText() {
            this.search = String(Date.now());
        },
        listDialog(newValue) {
            if (!newValue) {
                this.selectedSubject = {};
                this.classList = [];
            }
        },
        classDialog(newValue) {
            if (!newValue) {
                this.classId = null;
                this.classTeacher = '';
            }
        },
        studentDialog(newValue) {
            if (!newValue) {
                this.enrolledStudents = [];
                this.classId = null;
            }
        },
        editDialog(newValue) {
            if (!newValue)
                this.selectedSubject = {};
        }
    },
    mounted() {
        this.fetchSubjectData();
        this.fetchTeacherData();
        this.fetchStudentsData();
    },
    methods: {
        async fetchTeacherData() {
            var mySelf = this;
            await CallApi(`${this.$config.public.apiBaseUrl}/manage/staff/list`, {}, (response) => {
                mySelf.teacherList = response.staffs
            }, (error) => {
                // console.log('Error fetching staff data:', error);
            });
        },
        async fetchStudentsData() {
            var mySelf = this;
            await CallApi(`${this.$config.public.apiBaseUrl}/manage/student/list`, {
            }, (response) => {
                mySelf.studentList = response.students;
            }, (error) => {
                // console.log(error);
            }, this);
        },
        async fetchSubjectData() {
            var mySelf = this;
            await CallApi(`${this.$config.public.apiBaseUrl}/subject/list`, {}, (response) => {
                mySelf.subjectList = [];
                var subjects = [];
                response.subjects.forEach((item) => {
                    subjects.push({
                        subjectId: item.id,
                        subjectNo: item.subject_no,
                        SubjectName: item.subject_name,
                        numberOfLesson: item.number_of_lesson,
                        lessonDuration: item.lesson_duration,
                        list: 'Classes List',
                        edit: 'Edit'
                    })
                }, this);
                mySelf.subjectList = subjects;
                this.loadItems({ page: 1, itemsPerPage: mySelf.itemsPerPage, sortBy: [] });
            }, (error) => {
                // console.log('Error fetching staff data:', error);
            });
        },
        loadItems({ page, itemsPerPage, sortBy }) {
            this.loading = true;
            const start = (page - 1) * itemsPerPage;
            const end = start + itemsPerPage;
            const searchTerm = this.searchText.toLowerCase();

            const items = this.subjectList.slice().filter(item => {
                return (
                    item.subjectNo.toLowerCase().includes(searchTerm) ||
                    item.SubjectName.toLowerCase().includes(searchTerm)
                );
            });

            if (sortBy.length) {
                const sortKey = sortBy[0].key;
                const sortOrder = sortBy[0].order;
                items.sort((a, b) => {
                    const aValue = a[sortKey];
                    const bValue = b[sortKey];
                    return sortOrder === 'desc' ? bValue - aValue : aValue - bValue;
                });
            }

            const paginated = items.slice(start, end);
            this.serverItems = paginated;
            this.totalItems = items.length;
            this.loading = false;
        },
        handleEditButtonClick(item) {
            this.selectedSubject = { ...item };
            this.editDialog = true;
        },
        async subjectSave() {
            var mySelf = this;
            const payload = {
                id: this.selectedSubject.subjectId,
                subject_no: this.selectedSubject.subjectNo,
                subject_name: this.selectedSubject.SubjectName,
                number_of_lesson: this.selectedSubject.numberOfLesson,
                lesson_duration: this.selectedSubject.lessonDuration,
                // status: this.selectedItem.status ? 'true' : 'false',
            };

            const response = await CallApi(`${this.$config.public.apiBaseUrl}/manage/subject/edit`,
                payload, (response) => {
                    mySelf.fetchSubjectData();
                    mySelf.editDialog = false;
                }, (error) => {
                    // console.log('Failed to update staff information');
                }, this);
        },
        async handleListButtonClick(item) {
            this.selectedSubject = { ...item };
            await this.fetchClassesData(item.subjectId);
            this.listDialog = true;
        },
        async fetchClassesData(subjectId) {
            var mySelf = this;
            await CallApi(`${this.$config.public.apiBaseUrl}/subject/classes`, {
                id: subjectId
            }, (response) => {
                mySelf.classList = [];
                var classes = [];
                response.classes.forEach(item => {
                    classes.push({
                        subject_class_id: item.subject_class_id,
                        subject_id: item.subject_id,
                        staff_id: item.staff_id,
                        subject_no: item.subject_no,
                        subject_name: item.subject_name,
                        staff_no: item.staff_no,
                        surname: item.surname,
                        given_name: item.given_name,
                        lesson_start: this.formatDate(this.convertDateToJS(item.lesson_start)),
                        detail: 'Detail',
                        enroll: 'Students Enroll'
                    })
                })
                mySelf.classList = classes;
                // console.log('fetchClassesData')
                // console.log(mySelf.classList)

            }, (error) => {
                // console.log('Error fetching staff data:', error);
            });
            // console.log('Selected Item:', this.selectedItem);
        },
        handleNewClassButtonClick() {
            var mySelf = this;
            mySelf.scheduleList = [];
            for (var i = 0; i < this.selectedSubject.numberOfLesson; i++) {
                mySelf.scheduleList.push({
                    lesson_start: '',
                    lesson_end: ''
                })
            }
            mySelf.classDialog = true;
        },
        async handleDetailButtonClick(item) {
            this.classId = item.subject_class_id;
            this.classTeacher = item.staff_id;
            await this.fetchClassData(item.subject_class_id)
            this.classDialog = true;
        },
        async fetchClassData(subject_class_id) {
            var mySelf = this;
            await CallApi(`${this.$config.public.apiBaseUrl}/subject/scheduleByClass`, {
                id: subject_class_id
            }, (response) => {
                mySelf.scheduleList = [];
                var schedules = [];
                response.lessons.forEach(item => {
                    schedules.push({
                        id: item.id,
                        lesson_start: this.formatDate(this.convertDateToJS(item.lesson_start)),
                        lesson_end: this.formatDate(this.convertDateToJS(item.lesson_end)),
                    })
                })
                mySelf.scheduleList = schedules;
                // console.log(mySelf.scheduleList)
            }, (error) => {
                // console.log('Error fetching staff data:', error);
            });
            // console.log('Selected Item:', this.selectedItem);
        },
        createNewClass() {
            var mySelf = this;
            CallApi(`${this.$config.public.apiBaseUrl}/manage/subject/createClass`,
                {
                    subject_id: this.selectedSubject.subjectId,
                    staff_id: this.classTeacher,
                    lesson_duration: this.selectedSubject.lessonDuration,
                    schedules: this.scheduleList,
                }, (response) => {
                    mySelf.fetchClassesData(mySelf.selectedSubject.subjectId);
                    mySelf.classDialog = false;
                }, (error) => {
                    // console.log('Failed to update student information');
                }, this);
        },
        saveClass() {
            var mySelf = this;
            CallApi(`${this.$config.public.apiBaseUrl}/manage/subject/editClass`,
                {
                    class_id: this.classId,
                    staff_id: this.classTeacher,
                    lesson_duration: this.selectedSubject.lessonDuration,
                    schedules: this.scheduleList,
                }, (response) => {
                    mySelf.fetchClassesData(mySelf.selectedSubject.subjectId);
                    mySelf.classDialog = false;
                }, (error) => {
                    // console.log('Failed to update student information');
                }, this);
        },
        async handleEnrollButtonClick(item) {
            this.classId = item.subject_class_id;
            await this.fetchEnrolledStudentsData(item.subject_class_id);
            this.studentDialog = true;
        },
        async fetchEnrolledStudentsData(subject_class_id) {
            var mySelf = this;
            await CallApi(`${this.$config.public.apiBaseUrl}/subject/students`, {
                id: subject_class_id
            }, (response) => {
                mySelf.enrolledStudents = response.students.map(student => student.student_id);
            }, (error) => {
                // console.log(error);
            }, this);
        },
        async enrollStudent() {
            // console.log(this.enrolledStudents);
            var mySelf = this;
            await CallApi(`${this.$config.public.apiBaseUrl}/manage/class/enroll`, {
                subject_class_id: this.classId,
                students: this.enrolledStudents
            }, (response) => {
                this.studentDialog = false;
            }, (error) => {
                // console.log(error);
            }, this);
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
        },
    },
};
</script>

<style scoped>
.v-container {
    max-width: 1200px;
    margin: 0 auto;
}

.v-card {
    margin-top: 20px;
}

.v-data-table {
    margin-top: 20px;
}

.v-pagination {
    margin-top: 20px;
    justify-content: center;
}
</style>
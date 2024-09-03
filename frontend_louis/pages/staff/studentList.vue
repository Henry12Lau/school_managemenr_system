<template>
  <v-data-table-server v-model:items-per-page="itemsPerPage" :headers="headers" :items="serverItems"
    :items-length="totalItems" :loading="loading" :search="search" item-value="studentNum" @update:options="loadItems">
    <template v-slot:top>
      <tr>
        <td>
          <v-text-field v-model="name" class="ma-2" density="compact" placeholder="Search..." hide-details
            style="width: 300px;"></v-text-field>
        </td>
        <td class="w-100">
          <v-btn class="float-right" color="primary" @click="handleCreateButtonClick">Add</v-btn>
        </td>
      </tr>
    </template>
    <template v-slot:item.status="{ item }">
      <UBadge :label="item.status ? 'Inactive' : 'Active'" variant="subtle" class="mb-0.5"
        :color="item.status ? 'red' : 'blue'" />
    </template>
    <!-- <template v-slot:item.detail="{ item }">
      <v-btn outlined color="secondary" @click="handleButtonClick(item)">{{ item.detail }}</v-btn>
    </template> -->
    <template v-slot:item.edit="{ item }">
      <v-btn outlined color="primary" @click="handleButtonClick(item)">{{ item.edit }}</v-btn>
    </template>
  </v-data-table-server>

  <!-- Dialog Component -->
  <v-dialog v-model="dialog" max-width="500px">
    <v-card>
      <v-card-title>
        <span class="headline">Edit</span>
      </v-card-title>
      <v-card-text>
        <!-- Add your form or content here -->
        <v-select v-model="selectedItem.courseId" :items="courseList" item-title="course_name" item-value="course_id"
          label="Course" readonly></v-select>
        <v-text-field v-model="selectedItem.studentNum" label="Student No." readonly></v-text-field>
        <v-text-field v-model="selectedItem.surname" label="Surname"></v-text-field>
        <v-text-field v-model="selectedItem.givenName" label="Given Name"></v-text-field>
        <v-text-field v-model="selectedItem.tel" label="Phone"></v-text-field>
        <v-text-field v-model="selectedItem.loginID" label="Login ID" readonly></v-text-field>
        <v-text-field v-model="selectedItem.password" label="Password"></v-text-field>
        <v-select v-model="statusString" :items="['Active', 'Inactive']" label="Status"></v-select>
        <!-- Add more fields as needed -->
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1" text @click="dialog = false">Cancel</v-btn>
        <v-btn color="blue darken-1" text @click="saveItem">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>

  <v-dialog v-model="createDialog" max-width="500px">
    <v-card>
      <v-card-title>
        <span class="headline">New</span>
      </v-card-title>
      <v-card-text>
        <!-- Add your form or content here -->
        <v-select v-model="newStudent.course_id" :items="courseList" item-title="course_name" item-value="course_id"
          label="Course"></v-select>
        <v-text-field v-model="newStudent.student_no" label="Staff No."></v-text-field>
        <v-text-field v-model="newStudent.surname" label="Surname"></v-text-field>
        <v-text-field v-model="newStudent.given_name" label="Given Name"></v-text-field>
        <v-text-field v-model="newStudent.sex" label="Sex"></v-text-field>
        <v-text-field v-model="newStudent.tel" label="Phone"></v-text-field>
        <v-text-field v-model="newStudent.username" label="Login ID"></v-text-field>
        <v-text-field v-model="newStudent.password" label="Password"></v-text-field>
        <!-- Add more fields as needed -->
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1" text @click="createDialog = false">Cancel</v-btn>
        <v-btn color="blue darken-1" text @click="createStudent">Create</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data: () => ({
    itemsPerPage: 10,
    headers: [
      { title: 'Student No.', align: 'start', sortable: false, key: 'studentNum' },
      { title: 'Surname', key: 'surname', align: 'start' },
      { title: 'Given Name', key: 'givenName', align: 'start' },
      { title: 'Phone', key: 'tel', align: 'start' },
      { title: 'Login ID', key: 'loginID', align: 'start' },
      { title: 'Status', key: 'status', align: 'start' },
      { title: '', key: 'detail', align: 'end' },
      { title: '', key: 'edit', align: 'end' },
    ],
    serverItems: [],
    loading: true,
    totalItems: 0,
    name: '',
    search: '',
    dialog: false,
    selectedItem: {},
    list: [],
    courseList: [],
    createDialog: false,
    newStudent: {},
  }),
  computed: {
    statusString: {
      get() {
        return this.selectedItem.status ? 'Inactive' : 'Active';
      },
      set(newValue) {
        this.selectedItem.status = newValue === 'Inactive';
      },
    },
  },
  watch: {
    name() {
      this.search = String(Date.now());
    },
  },
  mounted() {
    this.fetchStudentData();
    this.fetchCourseData();
  },
  methods: {
    async fetchStudentData() {
      var mySelf = this;
      await CallApi(`${this.$config.public.apiBaseUrl}/manage/student/list`, {}, (response) => {
        mySelf.list = [];
        var students = [];
        response.students.forEach((item) => {
          students.push({
            courseId: item.course_id,
            studentId: item.id,
            studentNum: item.student_no,
            surname: item.surname,
            givenName: item.given_name,
            tel: item.tel,
            loginID: item.username,
            status: item.is_deleted,
            // detail: 'Detail',
            edit: 'Edit'
          })
        }, this);
        mySelf.list = students;
        this.loadItems({ page: 1, itemsPerPage: mySelf.itemsPerPage, sortBy: [] });
      }, (error) => {
        // console.log('Error fetching student data:', error);
      });
    },
    loadItems({ page, itemsPerPage, sortBy }) {
      this.loading = true;
      const start = (page - 1) * itemsPerPage;
      const end = start + itemsPerPage;
      const searchTerm = this.name.toLowerCase();

      const items = this.list.slice().filter(item => {
        return (
          item.studentNum.toLowerCase().includes(searchTerm) ||
          item.surname.toLowerCase().includes(searchTerm) ||
          item.givenName.toLowerCase().includes(searchTerm) ||
          item.tel.toLowerCase().includes(searchTerm) ||
          item.loginID.toLowerCase().includes(searchTerm)
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
    handleButtonClick(item) {
      this.selectedItem = { ...item };
      this.dialog = true;
    },
    async saveItem() {
      var mySelf = this;
      // console.log('Saving Item:', this.selectedItem);
      const payload = {
        surname: this.selectedItem.surname,
        given_name: this.selectedItem.givenName,
        tel: this.selectedItem.tel,
        password: this.selectedItem.password || '',
        student_no: this.selectedItem.studentNum,
        id: this.selectedItem.studentId,
        // status: this.selectedItem.status ? 'true' : 'false',
      };

      await CallApi(`${this.$config.public.apiBaseUrl}/manage/student/edit`,
        payload, (response) => {
          mySelf.fetchStudentData();
          mySelf.dialog = false;
        }, (error) => {
          // console.log('Failed to update student information');
        }, this);
    },
    async fetchCourseData() {
      var mySelf = this;
      mySelf.courseList = [];
      var courses = [];
      await CallApi(`${this.$config.public.apiBaseUrl}/course/list`, {}, (response) => {
        response.courses.forEach(course => {
          courses.push({
            course_id: course.id,
            course_name: '(' + course.category + ') ' + course.course_code + ' - ' + course.course_name
          })
        })
        mySelf.courseList = courses;
      }, (error) => {
        // console.log('Error fetching staff data:', error);
      });
    },
    handleCreateButtonClick() {
      this.createDialog = true;
    },
    async createStudent() {
      // console.log(this.newStudent);
      await CallApi(`${this.$config.public.apiBaseUrl}/manage/student/create`, {
        student_no: this.newStudent.student_no,
        course_id: this.newStudent.course_id,
        surname: this.newStudent.surname,
        given_name: this.newStudent.given_name,
        sex: this.newStudent.sex,
        tel: this.newStudent.tel,
        username: this.newStudent.username,
        password: this.newStudent.password
      }, (response) => {
        this.fetchStudentData();
        this.createDialog = false;
        this.newStudent = {};
      }, (error) => {
        // console.log('Error fetching staff data:', error);
      });
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
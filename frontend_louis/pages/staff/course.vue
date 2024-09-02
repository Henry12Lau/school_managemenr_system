<template>
  <v-btn color="primary" width="300px" @click="dialog = true">Mapping</v-btn>
  <div>
    <div v-for="(subjects, courseCode) in groupedCourses" :key="courseCode" class="course-section">
      <h3>{{ subjects[0].course_name }}</h3>
      <table>
        <thead>
          <tr>
            <th>Subject No</th>
            <th>Subject Name</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="subject in subjects" :key="subject.subject_no">
            <td>{{ subject.subject_no }}</td>
            <td>{{ subject.subject_name }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="headline">Course and Subject mapping</span>
        </v-card-title>
        <v-card-text>
          <v-form>
            <v-select v-model="selectedCourse" :items="courseOptions" item-title="course_name" item-value="course_id"
              label="Select Course"></v-select>
            <v-combobox v-model="selectedSubjects" :items="subjectOptions" item-title="subject_name"
              item-value="subject_id" label="Select the subject" :disabled="!selectedCourse" multiple></v-combobox>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">Cancel</v-btn>
          <v-btn color="blue darken-1" text @click="saveSelection">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      groupedCourses: [],
      dialog: false,
      courseOptions: [],
      subjectOptions: [],
      selectedCourse: null,
      selectedSubjects: []
    };
  },
  mounted() {
    this.getCourseMapping();
    this.getCourseSubject();
  },
  watch: {
    selectedCourse(newCourse) {
      if (newCourse) {
        this.selectedSubjects = this.groupedCourses[newCourse];
      }
    },
    dialog(newValue) {
      this.selectedCourse = null;
      this.selectedSubjects = [];
    }
  },
  methods: {
    async getCourseMapping() {
      var mySelf = this;
      await CallApi(`${this.$config.public.apiBaseUrl}/manage/course/mappingList`, {}, (response) => {
        mySelf.groupedCourses = mySelf.groupByCourse(response.course);
        // console.log('Grouped Courses:', mySelf.groupedCourses);
      }, (error) => {
        // console.error(error);
      }, this);
    },
    async getCourseSubject() {
      var mySelf = this;
      const response = await CallApi(`${this.$config.public.apiBaseUrl}/manage/getCourseSubject`, {}, (response) => {
        mySelf.courseOptions = response.courses;
        mySelf.subjectOptions = response.subjects;
      }, (error) => {
        // console.log(error);
      }, this);
    },
    groupByCourse(courses) {
      return courses.reduce((acc, course) => {
        if (!acc[course.course_id]) {
          acc[course.course_id] = [];
        }
        acc[course.course_id].push(course);
        return acc;
      }, {});
    },
    async saveSelection() {
      console.log('Selected Course:', this.selectedCourse);
      console.log('Selected Subject:', this.selectedSubjects.map(obj => obj.subject_id));
      var mySelf = this;
      await CallApi(`${this.$config.public.apiBaseUrl}/manage/course/mapping`, {
        course: this.selectedCourse,
        subjects: this.selectedSubjects.map(obj => obj.subject_id)
      }, (response) => {
        // mySelf.groupedCourses = mySelf.groupByCourse(response.course);
        // console.log('Grouped Courses:', mySelf.groupedCourses);
        mySelf.getCourseMapping();
        mySelf.dialog = false;
      }, (error) => {
        // console.error(error);
      }, this);
    }
  },
}
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

.course-section {
  margin-bottom: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
  /* Add margin between tables */
}

th,
td {
  border: 1px solid #ddd;
  padding: 8px;
}

th {
  background-color: #f2f2f2;
  text-align: left;
}
</style>
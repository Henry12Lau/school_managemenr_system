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
            <v-select v-model="selectedCourse" :items="courseOptions" item-title="course_name" item-value="course_code"
              label="Select Course"></v-select>
            <v-select v-model="selectedSubject" :items="subjectOptions" item-title="subject_name" item-value="subject_no"
              label="Select Subject" :disabled="!selectedCourse"></v-select>
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
      groupedCourses: {},
      dialog: false,
      selectedCourse: null,
      selectedSubject: null,
      courseOptions: [],
      subjectOptions: []
    };
  },
  mounted() {
    this.getCourseMapping();
    this.getCourseSubject();
  },
  watch: {
    selectedCourse(newCourse) {
      if (newCourse) {
        this.subjectOptions = this.groupedCourses[newCourse];
      } else {
        this.subjectOptions = [];
      }
    }
  },
  methods: {
    async getCourseMapping() {
      try {
        var mySelf = this;
        await CallApi(`${this.$config.public.apiBaseUrl}/manage/getCourseMapping`, {}, (response) => {
          mySelf.groupedCourses = mySelf.groupByCourse(response.course);
          console.log('Grouped Courses:', mySelf.groupedCourses);
        }, (error) => {
          console.error(error);
        }, this);
      } catch (error) {
        console.error(error);
      }
    },
    async getCourseSubject() {
      var mySelf = this;
      const response = await CallApi(`${this.$config.public.apiBaseUrl}/manage/getCourseSubject`, {}, (response) => {
        // const data = await response.json();
        // console.log('Courses and Subjects:', data);
        mySelf.courseOptions = response.courses;
        mySelf.subjectOptions = response.subjects;
        // let courseArr = []
        // for (let i = 0; i < data[0].course.length; i++) {
        // for (let i = 0; i < response[0].course.length; i++) {
        //   courseArr.push({
        //     // course_name: data.course[i].course_name
        //     course_name: response.course[i].course_name
        //   });
        // }
        // mySelf.selectedCourse = courseArr
        // console.log(courseArr)
      }, (error) => {
        console.error(error);
      }, this);
    },
    groupByCourse(courses) {
      return courses.reduce((acc, course) => {
        if (!acc[course.course_code]) {
          acc[course.course_code] = [];
        }
        acc[course.course_code].push(course);
        return acc;
      }, {});
    },
    saveSelection() {
      console.log('Selected Course:', this.selectedCourse);
      console.log('Selected Subject:', this.selectedSubject);
      this.dialog = false;
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
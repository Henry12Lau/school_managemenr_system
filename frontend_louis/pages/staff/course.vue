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
            <v-select v-model="selectedCourse" :items="course" item-text="course_name" item-value="course_code"
              label="Select Course"></v-select>
            <v-combobox v-model="selectedSubjects" :items="subject" label="Select the subject" multiple></v-combobox>
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
      course: null,
      subject: null,
      courseOptions: [],
      subjectOptions: [],
      selectedCourse: [],
      selectedSubjects: [] // New data property to store selected subjects
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
        const response = await fetch(`${this.$config.public.apiBaseUrl}/staff/getCourseMapping`);
        const data = await response.json();
        this.groupedCourses = this.groupByCourse(data.course);
        console.log('Grouped Courses:', this.groupedCourses);
      } catch (error) {
        console.error(error);
      }
    },
    async getCourseSubject() {
      try {
        const response = await fetch(`${this.$config.public.apiBaseUrl}/staff/getCourseSubject`);
        const data = await response.json();
        console.log('Courses and Subjects:', data);
        let courseArr = []
        let subjectArr = []
        for (let i = 0; i < data.courses.length; i++) {
          courseArr.push(data.courses[i].course_name);
        }
        for (let i = 0; i < data.subjects.length; i++) {
          subjectArr.push(data.subjects[i].subject_name);
        }
        this.course = courseArr;
        this.subject = subjectArr; 
      } catch (error) {
        console.error(error);
      }
    },
    async saveSelection() {
      console.log('Selected Course:', this.selectedCourse);
      console.log('Selected Subjects:', this.selectedSubjects); // Log the selected subjects
      // Add logic to store the selected subjects
      // const payload = {
      //   course: this.selectedCourse.course_name,
      //   subjects: this.selectedSubjects.subject_name
      // };
      // try {
      //   const response = await fetch(`${this.$config.public.apiBaseUrl}/staff/courseMapping`, {
      //     method: 'POST',
      //     headers: {
      //       'Content-Type': 'application/json'
      //     },
      //     body: JSON.stringify(payload)
      //   });

      //   if (!response.ok) {
      //     throw new Error('Network response was not ok');
      //   }

      //   const result = await response.json();
      //   console.log('Save result:', result);
      //   // Handle success (e.g., show a success message, update UI, etc.)
      // } catch (error) {
      //   console.error('Error saving course and subject mapping:', error);
      //   // Handle error (e.g., show an error message)
      // }
      this.dialog = false;
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
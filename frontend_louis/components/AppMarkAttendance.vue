<template>
  <v-dialog v-model="dialog" width="auto" scrollable persistent>
    <v-card>
      <v-card-title>
        <span class="text-h5">Attendance</span>
      </v-card-title>
      <v-divider class="mt-3"></v-divider>
        <v-card-text class="px-4">
          <v-data-table v-model="selected" :headers="headers" :items="attendances" item-value="student_id" show-select :disable-pagination="true" :hide-default-footer="true"></v-data-table>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-btn text="Close" @click="closeDialog()"></v-btn>
          <v-spacer></v-spacer>
          <v-btn color="surface-variant" text="Save" variant="flat" @click="updateAttendance()"></v-btn>
        </v-card-actions>
    </v-card>
  </v-dialog>
</template>
<script>
export default {
  props: {
    permission: {
      type: String,
      required: true,
    },
    userId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
      userId: 0,
      lessonId: 0,
      selected: [],
      attendances: [],
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
    };
  },
  methods: {
    closeDialog() {
      this.dialog = false;
    },
    async start(lessonId){
      this.lessonId = lessonId
      await this.fetchClassAttendance();
      this.dialog = true;
    },
    async fetchClassAttendance() {
      this.loading = true;
      const mySelf = this;
      mySelf.attendances = [];
      await CallApi(`${this.$config.public.apiBaseUrl}/staff/lessonAttendance`, {
        id: mySelf.lessonId,
      }, (response) => {
        mySelf.attendances = response.attendances;
        const selected = []
        response.attendances.forEach(student => {
        if (student.is_attend)
            selected.push(student.student_id);
        });
        mySelf.selected = selected;
        // console.log(mySelf.attendances);
      }, (error) => {
        // console.log(error);
      });
      this.loading = false;
    },
    async updateAttendance() {
      this.loading = true;
      const mySelf = this;
      mySelf.attendances = [];
      await CallApi(`${this.$config.public.apiBaseUrl}/staff/updateAttendances`, {
        id: mySelf.userId,
        lessonId: mySelf.lessonId,
        studentIds: mySelf.selected,
      }, (response) => {
        mySelf.closeDialog();
      }, (error) => {
        // console.log(error);
      });
      this.loading = false;
    },
  },
};
</script>
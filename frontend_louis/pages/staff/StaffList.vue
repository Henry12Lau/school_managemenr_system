<template>
  <v-data-table-server v-model:items-per-page="itemsPerPage" :headers="headers" :items="serverItems"
    :items-length="totalItems" :loading="loading" :search="search" item-value="staffNum" @update:options="loadItems">
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
        <v-select v-model="selectedItem.titleId" :items="titleList" item-title="title_name" item-value="id"
        label="Title"></v-select>
        <v-text-field v-model="selectedItem.staffNum" label="Staff No." readonly></v-text-field>
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
        <v-select v-model="newStaff.title_id" :items="titleList" item-title="title_name" item-value="id"
        label="Title"></v-select>
        <v-text-field v-model="newStaff.staff_no" label="Staff No."></v-text-field>
        <v-text-field v-model="newStaff.surname" label="Surname"></v-text-field>
        <v-text-field v-model="newStaff.given_name" label="Given Name"></v-text-field>
        <v-text-field v-model="newStaff.sex" label="Sex"></v-text-field>
        <v-text-field v-model="newStaff.tel" label="Phone"></v-text-field>
        <v-text-field v-model="newStaff.username" label="Login ID"></v-text-field>
        <v-text-field v-model="newStaff.password" label="Password"></v-text-field>
        <!-- Add more fields as needed -->
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1" text @click="createDialog = false">Cancel</v-btn>
        <v-btn color="blue darken-1" text @click="createStaff">Create</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data: () => ({
    itemsPerPage: 10,
    headers: [
      { title: 'Staff No.', align: 'start', sortable: false, key: 'staffNum' },
      { title: 'Surname', key: 'surname', align: 'start' },
      { title: 'Given Name', key: 'givenName', align: 'start' },
      { title: 'Phone', key: 'tel', align: 'start' },
      { title: 'Login ID', key: 'loginID', align: 'start' },
      { title: 'Post', key: 'title_name', align: 'start' },
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
    titleList: [],
    createDialog: false,
    newStaff: {},
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
    this.fetchStaffData();
    this.fetchTitleData();
  },
  methods: {
    async fetchStaffData() {
      var mySelf = this;
      await CallApi(`${this.$config.public.apiBaseUrl}/manage/staff/list`, {}, (response) => {
        mySelf.list = [];
        var staffs = [];
        response.staffs.forEach((item) => {
          staffs.push({
            titleId: item.title_id,
            staffId: item.id,
            staffNum: item.staff_no,
            surname: item.surname,
            givenName: item.given_name,
            tel: item.tel,
            loginID: item.username,
            title_name: item.title_name,
            status: item.is_deleted,
            // detail: 'Detail',
            edit: 'Edit'
          })
        }, this);
        mySelf.list = staffs;
        this.loadItems({ page: 1, itemsPerPage: mySelf.itemsPerPage, sortBy: [] });
      }, (error) => {
        // console.log('Error fetching staff data:', error);
      });
    },
    loadItems({ page, itemsPerPage, sortBy }) {
      this.loading = true;
      const start = (page - 1) * itemsPerPage;
      const end = start + itemsPerPage;
      const searchTerm = this.name.toLowerCase();

      const items = this.list.slice().filter(item => {
        return (
          item.staffNum.toLowerCase().includes(searchTerm) ||
          item.surname.toLowerCase().includes(searchTerm) ||
          item.givenName.toLowerCase().includes(searchTerm) ||
          item.tel.toLowerCase().includes(searchTerm) ||
          item.title_name.toLowerCase().includes(searchTerm) ||
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
      console.log('Selected Item:', this.selectedItem);
      this.dialog = true;
    },
    async saveItem() {
      var mySelf = this;
      // console.log('Saving Item:', this.selectedItem);
      const payload = {
        title_id: this.selectedItem.titleId,
        surname: this.selectedItem.surname,
        given_name: this.selectedItem.givenName,
        tel: this.selectedItem.tel,
        password: this.selectedItem.password || '',
        staff_no: this.selectedItem.staffNum,
        title_name: this.selectedItem.title_name,
        id: this.selectedItem.staffId,
        // status: this.selectedItem.status ? 'true' : 'false',
      };

      const response = await CallApi(`${this.$config.public.apiBaseUrl}/manage/staff/edit`,
        payload, (response) => {
          mySelf.fetchStaffData();
          mySelf.dialog = false;
        }, (error) => {
          // console.log('Failed to update staff information');
        }, this);
    },
    async fetchTitleData() {
      var mySelf = this;
      mySelf.titleList = [];
      await CallApi(`${this.$config.public.apiBaseUrl}/manage/staff/title`, {}, (response) => {
        mySelf.titleList = response.titles;
      }, (error) => {
        // console.log('Error fetching staff data:', error);
      });
    },
    handleCreateButtonClick() {
      this.createDialog = true;
    },
    async createStaff() {
      await CallApi(`${this.$config.public.apiBaseUrl}/manage/staff/create`, {
        title_id: this.newStaff.title_id,
        staff_no: this.newStaff.staff_no,
        surname: this.newStaff.surname,
        given_name: this.newStaff.given_name,
        sex: this.newStaff.sex,
        tel: this.newStaff.tel,
        username: this.newStaff.username,
        password: this.newStaff.password,
        
      }, (response) => {
        this.fetchStaffData();
        this.createDialog = false;
        this.newStaff = {};
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
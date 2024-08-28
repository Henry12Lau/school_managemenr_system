<!-- <script>
export default {
  mounted() {
    this.$router.push('/student/calendar');
  },
};
</script> -->
<template>
  <v-layout>
    <v-navigation-drawer v-model="drawer">
      <v-list density="compact" item-props :items="items" nav>
        <v-list-item
          v-for="item in items"
          :key="item.title"
          :prepend-icon="item.prependIcon"
          :title="item.title"
          link
          @click="navigateTo(item.title)"
        />
      </v-list>
    </v-navigation-drawer>

    <v-app-bar border="b" class="ps-4" flat>
      <v-app-bar-nav-icon
        v-if="$vuetify.display.smAndDown"
        @click="drawer = !drawer"
      />

      <v-app-bar-title>Welcome back!</v-app-bar-title>

      <template #append>
        <v-btn class="text-none me-2" height="48" icon slim>
          <v-avatar
            color="surface-light"
            image="https://cdn-icons-png.freepik.com/512/201/201818.png"
            size="32"
          />

          <v-menu activator="parent">
            <v-list density="compact" nav>
              <v-list-item append-icon="mdi-logout" link title="Logout" />
            </v-list>
          </v-menu>
        </v-btn>
      </template>
    </v-app-bar>

    <v-main style="height: 500px;">
      <v-card-text v-if="currentView === 'Home'">
        This is the Content
      </v-card-text>
      <CalendarView v-if="currentView === 'Calendar'" />
    </v-main>
  </v-layout>
</template>

<script setup>
import { ref } from 'vue'
import CalendarView from './CalendarView.vue' // Import the Calendar component

const drawer = ref(true)

const currentView = ref('Home')

const items = ref([
  {
    title: 'Dashboard',
    prependIcon: 'mdi-view-dashboard-outline',
    link: true,
  },
  {
    title: 'Team',
    prependIcon: 'mdi-account-group',
    link: true,
  },
  {
    title: 'Projects',
    prependIcon: 'mdi-briefcase-outline',
    link: true,
  },
  {
    title: 'Calendar',
    prependIcon: 'mdi-calendar',
    link: true,
  },
  {
    title: 'Reports',
    prependIcon: 'mdi-file-chart-outline',
    link: true,
  },
])

function navigateTo(view) {
  currentView.value = view
}
</script>

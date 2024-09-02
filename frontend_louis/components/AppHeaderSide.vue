<template>
    <v-navigation-drawer v-model="drawer">
        <v-list density="compact" item-props :items="links" nav />
        <template #append>
            <v-list-item class="ma-2" link nav prepend-icon="mdi-logout" title="Logout" to="/logout" />
        </template>
    </v-navigation-drawer>

    <v-app-bar border="b" class="ps-4" flat>
        <v-app-bar-nav-icon @click="drawer = !drawer" />

        <v-app-bar-title>School Management System</v-app-bar-title>

        <!-- <template #append>
            <v-btn class="text-none me-2" height="48" icon slim>
                <v-avatar color="surface-light" image="https://cdn-icons-png.freepik.com/512/201/201818.png"
                    size="32" />

                <v-menu activator="parent">
                    <v-list density="compact" nav>
                        <v-list-item append-icon="mdi-logout" value="logout" link title="Logout" to="/logout" />
                    </v-list>
                </v-menu>
            </v-btn>
        </template> -->
    </v-app-bar>
</template>

<script>
export default {
    data() {
        return {
            permission: '',
            drawer: false,
            links: [],
        };
    },
    async mounted() {
        var mySelf = this;
        await CallApi(`${this.$config.public.apiBaseUrl}/auth/session`, {
        }, (response) => {
            mySelf.SetMenuItem(response.permission)
        }, (error) => {
            // console.log(error);
        });
    },
    methods: {
        SetMenuItem(permission) {
            if (permission == "student") {
                this.links = [{
                    title: 'Calendar',
                    prependIcon: 'mdi-calendar',
                    link: true,
                    to: '/student/calendar'
                }, {
                    title: 'Subjects',
                    prependIcon: 'mdi-briefcase-outline',
                    link: true,
                    to: '/student/list'
                }]
            } else if (permission == "teacher") {
                this.links = [{
                    title: 'Calendar',
                    prependIcon: 'mdi-calendar',
                    link: true,
                    to: '/staff/calendar'
                }, {
                    title: 'Subjects',
                    prependIcon: 'mdi-briefcase-outline',
                    link: true,
                    to: '/staff/subject'
                }, {
                    title: 'Student',
                    prependIcon: 'mdi-account-circle-outline',
                    link: true,
                    to: '/staff/student_list'
                },]
            } else {
                this.links = [{
                    title: 'Calendar',
                    prependIcon: 'mdi-calendar',
                    link: true,
                    to: '/staff/calendar'
                }, {
                    title: 'Subjects',
                    prependIcon: 'mdi-briefcase-outline',
                    link: true,
                    to: '/staff/subject'
                }, {
                    title: 'Student',
                    prependIcon: 'mdi-account-circle-outline',
                    link: true,
                    to: '/staff/studentList'
                }, {
                    title: 'Course',
                    prependIcon: 'mdi-briefcase-outline',
                    link: true,
                    to: '/staff/course'
                },]
            };
        }
    }
}
</script>

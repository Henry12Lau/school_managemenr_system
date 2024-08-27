<!-- <script setup>

const links = [{
    label: 'School Management System',
    badge: 'SMS',
    to: '/staff',
}, {
    label: 'Calendar',
    to: '/staff/calendar'
}, {
    label: 'Subjects',
    to: '/staff/subject'
}, {
    label: 'Logout',
    to: '/logout'
},
];

</script> -->
<script>
export default {
    data() {
        return {
            permission: '',
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
                    label: 'School Management System',
                    badge: 'SMS',
                    to: '/student',
                }, {
                    label: 'Calendar',
                    to: '/student/calendar'
                }, {
                    label: 'Subjects',
                    to: '/student/list'
                }, {
                    label: 'Logout',
                    to: '/logout'
                },]
            } else {
                this.links = [{
                    label: 'School Management System',
                    badge: 'SMS',
                    to: '/staff',
                }, {
                    label: 'Calendar',
                    to: '/staff/calendar'
                }, {
                    label: 'Subjects',
                    to: '/staff/subject'
                }, {
                    label: 'Logout',
                    to: '/logout'
                },]
            }

        }
    }
};
</script>

<template>
    <UHorizontalNavigation :links="links">
        <template #default="{ link }">
            <span class="group-hover:text-primary relative">{{ link.label }}</span>
        </template>
    </UHorizontalNavigation>
</template>

const StudentRoutes = {
  path: '/main',
  meta: {
    requiresAuth: true
  },
  redirect: '/main/student/calendar',
  component: () => import('@/pages/student/calendar.vue'),
  // children: [
  //   {
  //     name: 'LandingPage',
  //     path: '/',
  //     component: () => import('@/views/dashboards/default/DefaultDashboard.vue')
  //   },
  //   {
  //     name: 'Default',
  //     path: '/dashboard/default',
  //     component: () => import('@/views/dashboards/default/DefaultDashboard.vue')
  //   }
  // ]
};

export default StudentRoutes;

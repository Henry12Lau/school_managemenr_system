<script>
export default {
    async mounted() {
        await CallApi(`${this.$config.public.apiBaseUrl}/auth/logout`, {
        }, (response) => {
        }, (error) => {
            // console.log(error);
        });
        this.$router.push('/login');
    },
};
</script>
<template></template>
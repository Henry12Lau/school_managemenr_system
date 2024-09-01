
<script setup>
definePageMeta({
  layout: false,
});
</script>
<script>
export default {
    data() {
        return {
            username: '',
            password: '',
            type: 'Student',
            loading: false,
            error: null,
            loginTypes: ['Student', 'Staff'],
            errorMessage: false,
            timeout: 2000,
        };
    },
    methods: {
        async login() {
            this.loading = true;
            await CallApi(`${this.$config.public.apiBaseUrl}/auth/login`, {
                type: this.type.toLowerCase(),
                username: this.username,
                password: this.password,
            }, (response) => {
                if (this.type.toLowerCase() == "student") {
                    this.$router.push('/student');
                } else {
                    this.$router.push('/staff');
                }
            }, (error) => {
                console.log(error);
                this.error = 'Invalid username or password';
                this.errorMessage = true;
            });
            this.loading = false;
        },
    },
};
</script>
<template>  

    <div class="d-flex justify-center align-center" style="height:80vh;">
        <v-form @submit.prevent="login">
            <v-card class="mx-auto" width="400">
                <v-card-title><span class="font-weight">School Management System </span><UBadge label="SMS" variant="subtle" class="mb-0.5" /></v-card-title>
                <v-card-subtitle><span class="font-weight">Login</span></v-card-subtitle>
                <v-card-text class="pb-0">
                    <v-text-field v-model="username" label="Username" required></v-text-field>
                    <v-text-field v-model="password" type="password" label="Password" required></v-text-field>
                    <v-select v-model="type" :items="loginTypes" label="Login Type"></v-select>
                </v-card-text>
                <v-card-actions><v-btn type="submit" block color="primary">Login</v-btn></v-card-actions>
            </v-card>
        </v-form>
    </div>
    <v-snackbar v-model="errorMessage" :timeout="timeout">
        {{ error }}
        <template v-slot:actions>
            <v-btn color="blue" :variant="error" @click="errorMessage = false">
                Close
            </v-btn>
        </template>
    </v-snackbar>
</template>


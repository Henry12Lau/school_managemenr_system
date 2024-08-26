<template>
    <div class="d-flex justify-center align-center" style="height:100vh;">
        <v-form @submit.prevent="login">
            <v-card class="mx-auto" width="400">
                <v-card-title><span class="font-weight">School Management System</span></v-card-title>
                <v-card-subtitle><span class="font-weight">Login</span></v-card-subtitle>
                <v-card-text class="pb-0">
                    <v-text-field v-model="username" label="Username" required></v-text-field>
                    <v-text-field v-model="password" type="password" label="Password" required></v-text-field>
                    <v-select v-model="type" :items="loginTypes" label="Login Type"></v-select>
                </v-card-text>
                <v-card-action><v-btn type="submit" block>Login</v-btn></v-card-action>
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
            try {
                this.loading = true;
                const response = await $fetch(`${this.$config.public.apiBaseUrl}/auth/login`, {
                    method: 'POST',
                    body: {
                        type: this.type.toLowerCase(),
                        username: this.username,
                        password: this.password,
                    },

                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                // Handle successful login
                if (this.type.toLowerCase() == "student") {
                    await this.$router.push('/student');
                } else {
                    await this.$router.push('/staff');
                }
            } catch (error) {
                this.error = error.response.message || 'Invalid username or password';
                this.errorMessage = true;
            } finally {
                this.loading = false;
            }
        },
    },
};
</script>

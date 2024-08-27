<template>
    <AppHeader />
    <v-card>
        <v-layout>
            <v-container>
                <v-main>
                    <slot />
                </v-main>
            </v-container>
        </v-layout>
    </v-card>
    <AppFooter />
</template>

<!-- <template>
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
</template> -->

<template>
    <!-- <AppHeader /> -->
    <v-card>
        <v-layout>
            <AppHeaderSide />
            <v-main>
                <v-container>
                    <slot />
                </v-container>
            </v-main>
        </v-layout>
    </v-card>
    <!-- <AppFooter /> -->
</template>

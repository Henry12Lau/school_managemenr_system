<script setup lang="ts">
useSeoMeta({
  titleTemplate: 'School Management System',
})
import { CallApi } from '@/utils/ApiService';
</script>
<template>
  <NuxtLayout>
    <v-app>
      <NuxtPage />
    </v-app>
  </NuxtLayout>
</template>

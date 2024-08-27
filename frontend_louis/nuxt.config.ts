import vuetify, { transformAssetUrls } from 'vite-plugin-vuetify'
export default defineNuxtConfig({
  //...
  components: [
    {
      path: '~/components',
      pathPrefix: false,
    },
  ],
  build: {
    transpile: ['vuetify'],
  },
  extends: ['@nuxt/ui-pro'],
  modules: [
    (_options, nuxt) => {
      nuxt.hooks.hook('vite:extendConfig', (config) => {
        // @ts-expect-error
        config.plugins.push(vuetify({ autoImport: true }))
      })
    },
    //...
    '@nuxt/ui',
  ],
  vite: {
    vue: {
      template: {
        transformAssetUrls,
      },
    },
  },
  runtimeConfig: {
    public: {
      apiBaseUrl: 'http://localhost:8080'
    }
  },
  
})
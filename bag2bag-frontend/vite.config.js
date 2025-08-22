import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
  },
  server: {
    proxy: {
      // 只要前端請求以 /api 開頭，就會自動轉發到 Spring Boot
      '/api': {
        target: 'http://localhost:8080',  // 你的 Spring Boot 後端端口
        changeOrigin: true,               // 避免 CORS 問題
      }
    }
  }
})

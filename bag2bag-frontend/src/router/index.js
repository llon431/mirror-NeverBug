import { createRouter, createWebHistory } from 'vue-router'
const Home = () => import('../pages/Home.vue')

export default createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', name: 'home', component: Home },
    // 之後有其他頁面再加
  ],
  scrollBehavior: () => ({ top: 0 }),
})

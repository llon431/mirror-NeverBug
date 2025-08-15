<template>
  <header class="header">
    <!-- Top bar -->
    <div class="topbar">
      <router-link class="logo" to="/">
        <span class="brand-1">BAG</span><span class="brand-2">2BAG</span>
      </router-link>

      <div class="center-icon" aria-label="brand">
        <BagIcon />
      </div>

      <button class="hamburger" @click="drawer = true" aria-label="menu">
        <span></span><span></span><span></span>
      </button>
    </div>

    <!-- Search bar -->
    <div class="search-row">
      <el-input
        v-model="keyword"
        placeholder="Search  Computer Sci"
        class="search-input"
        size="large"
        @keyup.enter="onSearch"
        clearable
      />
      <el-button class="search-btn" size="large" round @click="onSearch">
        <el-icon><Search /></el-icon>
      </el-button>
    </div>

    <!-- Quick categories -->
    <nav class="quick-cats">
      <button v-for="c in cats" :key="c.key" class="cat-btn">
    <span class="cat-icon">
      <img :src="c.img" :alt="c.label" />
    </span>
        <span class="cat-text">{{ c.label }}</span>
      </button>
    </nav>

    <!-- Drawer -->
    <el-drawer v-model="drawer" :with-header="false" size="260px">
      <div class="drawer-inner">
        <h3>Menu</h3>
        <ul class="drawer-links">
          <li><router-link to="/">Home</router-link></li>
          <li><a href="#">About</a></li>
          <li><router-link to="/">Login</router-link></li>
        </ul>
      </div>
    </el-drawer>
  </header>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { Search } from '@element-plus/icons-vue'

const router = useRouter()
const drawer = ref(false)
const keyword = ref('')

const cats = [
  { key: 'univ', label: 'university', img: '/university.png' },
  { key: 'tech', label: 'tech', img: '/tech.png' },
  { key: 'clothes', label: 'clothes', img: '/clothes.png' },
  { key: 'sports', label: 'sports', img: '/sports.png' },
  { key: 'living', label: 'living', img: '/living.png' },
  { key: 'other', label: 'others', img: '/others.png' }
]

function onSearch() {
  // 之後可改為 /search?kw=xxx
  router.push({ name: 'home', query: { q: keyword.value } })
}

function goCategory(c) {
  // 之後接上你的分類路由
  console.log('go category:', c)
}

/* 簡易 SVG 圖示 */
const BagIcon = {
  name: 'BagIcon',
  template: `
  <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
    <path d="M6 8h12l1 12H5L6 8Z"/><path d="M9 8V6a3 3 0 0 1 6 0v2"/>
  </svg>`
}
const CatIcon = {
  name: 'CatIcon',
  template: `
  <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round">
    <rect x="4" y="4" width="16" height="12" rx="2"/><path d="M8 20h8"/>
  </svg>`
}
</script>

<style scoped>

.header { background: #fff; }


.logo { color: var(--nav-fg); text-decoration: none; font-weight: 800; letter-spacing: .5px; }
.brand-1 { opacity: .95; }
.brand-2 { margin-left: 2px; }
.center-icon { display:flex; justify-content:center; }
.hamburger {
  margin-left: auto;
  width: 38px; height: 30px;
  display:flex; flex-direction:column; justify-content:space-between;
  background: transparent; border: none; cursor: pointer;
}
.hamburger span { display:block; height:3px; background: #fff; border-radius: 2px; }

/* Search row */
.search-row {
  display:flex; align-items:center; gap:10px;
  padding: 14px 16px 10px;
  background: #fff;
  border-bottom: 1px solid #f0f2f5;
}
.search-input :deep(.el-input__wrapper) {
  border-radius: 999px;
  background: var(--pill);
  border: 1px solid var(--pill-bd);
  box-shadow: none;
}
.search-input { max-width: 720px; width: 100%; }
.search-btn { border-radius: 999px; }

/* Quick categories */
.quick-cats {
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 12px;
  padding: 8px 150px 16px; /* 左右變成 40px */
}

.cat-btn {
  cursor: pointer;
  border: none;
  background: var(--nav-bg);
  color: #fff;
  border-radius: 30px;
  width: 150px;           /* 固定寬度 */
  height: 150px;          /* 固定高度，正方形 */
  display:flex; flex-direction:column; align-items:center; justify-content:center;
  transition: transform .08s ease;
}

.cat-btn:active { transform: scale(.98); }
.cat-icon {
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 10px;
  margin-bottom: 6px;
  overflow: hidden; /* 防止圖片溢出 */
}

.cat-icon img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 填滿裁切 */
}
.cat-text { font-size: 13px; }




/* Drawer */
.drawer-inner { padding: 12px; }
.drawer-links { list-style:none; padding-left:0; }
.drawer-links li { margin: 10px 0; }
.drawer-links a { color:#333; text-decoration:none; }

/* RWD */
@media (max-width: 768px) {
  .quick-cats { grid-template-columns: repeat(3, 1fr); }
}
</style>

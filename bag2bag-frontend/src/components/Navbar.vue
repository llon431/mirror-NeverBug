<template>
  <header>
    <!-- 深藍滿版頂欄 -->
    <div class="topbar">
      <div class="bar-inner">
        <router-link class="logo" to="/">
          <span class="brand-1">BAG</span><span class="brand-2">2BAG</span>
        </router-link>

        <div class="center-icon" aria-label="brand"><BagIcon /></div>

        <button class="hamburger" @click="drawer = true" aria-label="menu">
          <span></span><span></span><span></span>
        </button>
      </div>
    </div>

    <!-- 白底內容：只有搜尋列 -->
    <div class="content">
      <div class="content-inner">
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
      </div>
    </div>

    <!-- 側邊選單 -->
    <el-drawer v-model="drawer" :with-header="false" size="260px">
      <div class="drawer-inner">
        <h3>Menu</h3>
        <ul class="drawer-links">
          <li><router-link to="/">Home</router-link></li>
          <li><router-link to="/login">Login</router-link></li>
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

function onSearch() {
  router.push({ name: 'home', query: { q: keyword.value } })
}

/* 極簡 logo 圖示 */
const BagIcon = {
  name: 'BagIcon',
  template: `
  <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
    <path d="M6 8h12l1 12H5L6 8Z"/><path d="M9 8V6a3 3 0 0 1 6 0v2"/>
  </svg>`
}
</script>

<style scoped>
/* 視覺樣式 */
.logo { color: var(--nav-fg); text-decoration:none; font-weight:800; letter-spacing:.5px; }
.brand-2 { margin-left:2px; }
.center-icon { display:flex; justify-content:center; }

.hamburger {
  margin-left:auto; width:38px; height:30px;
  display:flex; flex-direction:column; justify-content:space-between;
  background:transparent; border:none; cursor:pointer;
}
.hamburger span { display:block; height:3px; background:#fff; border-radius:2px; }

.search-row { display:flex; align-items:center; gap:10px; padding:8px 0 10px; }
.search-input :deep(.el-input__wrapper) {
  border-radius:999px; background:var(--pill); border:1px solid var(--pill-bd); box-shadow:none;
}
.search-input { max-width:720px; width:100%; }
.search-btn { border-radius:999px; }

.drawer-inner { padding:12px; }
.drawer-links { list-style:none; padding-left:0; }
.drawer-links li { margin:10px 0; }
.drawer-links a { color:#333; text-decoration:none; }
</style>

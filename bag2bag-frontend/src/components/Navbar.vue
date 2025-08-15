<template>
  <header>
    <!-- 深蓝满版顶栏 -->
    <div class="topbar">
      <div class="bar-inner">
        <router-link class="logo" to="/">
          <span class="brand-1">BAG</span><span class="brand-2">2BAG</span>
        </router-link>

        <!-- 中间 Logo 图标 -->
        <div class="center-icon"><BagIcon /></div>

        <!-- 菜单按钮 -->
        <button class="hamburger" @click="drawer = true" aria-label="menu">
          <span></span><span></span><span></span>
        </button>
      </div>
    </div>

    <!-- 白底内容：搜索栏 -->
    <div class="content">
      <div class="content-inner">
        <div class="search-row">
          <el-input
            v-model="keyword"
            placeholder="Search Computer Sci"
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

    <!-- 侧边栏 Drawer -->
    <el-drawer v-model="drawer" :with-header="false" size="260px">
      <div class="drawer-inner">
        <!-- 用户信息 -->
        <div class="user-info">
          <el-avatar :src="user.avatar" size="large" />
          <span class="username">{{ user.name }}</span>
        </div>

        <!-- 菜单列表 -->
        <el-menu class="el-menu-vertical-demo" @select="onMenuSelect">
          <el-menu-item index="/">
            <span>首页</span>
          </el-menu-item>

          <el-menu-item index="/my-backpack">
            <span>我的背包</span>
          </el-menu-item>

          <el-menu-item index="/my-favorites">
            <span>收藏夹</span>
            <el-badge :value="favoritesCount" class="badge" />
          </el-menu-item>

          <el-menu-item index="/history">
            <span>历史浏览</span>
          </el-menu-item>

          <el-menu-item index="/login">
            <span>登录</span>
          </el-menu-item>
        </el-menu>
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

// 用户信息
const user = ref({
  name: '用户名',
  avatar: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png'
})

// 收藏夹数量设为12
const favoritesCount = ref(12)

// 搜索跳转函数
function onSearch() {
  router.push({ name: 'home', query: { q: keyword.value } })
}

// 菜单选择函数：点击菜单跳转并关闭 Drawer
function onMenuSelect(index) {
  router.push(index)
  drawer.value = false
}

// BagIcon 组件
const BagIcon = {
  name: 'BagIcon',
  template: `
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
      <path d="M6 8h12l1 12H5L6 8Z"/>
      <path d="M9 8V6a3 3 0 0 1 6 0v2"/>
    </svg>`
}
</script>

<style scoped>
/* drawer 样式 */
.drawer-inner { padding:12px; }
.user-info { display:flex; align-items:center; padding:20px; border-bottom:1px solid #ebeef5; gap:12px; }
.username { font-size:16px; font-weight:500; color:#303133; }
.el-menu-vertical-demo { border:none; flex:1; }
.el-menu-item { position:relative; }
.badge { position:absolute; right:20px; top:50%; transform:translateY(-50%); }

/* 顶栏样式 */
.logo { color: var(--nav-fg); text-decoration:none; font-weight:800; letter-spacing:.5px; }
.brand-2 { margin-left:2px; }
.center-icon { display:flex; justify-content:center; }
.hamburger { margin-left:auto; width:38px; height:30px; display:flex; flex-direction:column; justify-content:space-between; background:transparent; border:none; cursor:pointer; }
.hamburger span { display:block; height:3px; background:#fff; border-radius:2px; }

/* 搜索栏 */
.search-row { display:flex; align-items:center; gap:10px; padding:8px 0 10px; }
.search-input :deep(.el-input__wrapper) { border-radius:999px; background:var(--pill); border:1px solid var(--pill-bd); box-shadow:none; }
.search-input { max-width:720px; width:100%; }
.search-btn { border-radius:999px; }
</style>

<template>
  <main class="page-container">
    <!-- 頂部導航欄 -->
    <header class="navbar">
      <h1 class="logo">BAG2BAG</h1>
      <button class="menu-btn" @click="toggleDrawer">☰</button>
    </header>

    <!-- Drawer 側拉框 -->
    <Drawer :isOpen="drawerOpen" />

    <section class="content">
      <!-- 搜尋下方：推薦連結/快捷導覽（示例） -->
      <section class="quick-cats">
        <button
          v-for="c in cats"
          :key="c.key"
          class="cat-btn"
          @click="goCategory(c)"
        >
          <span class="cat-icon">
            <img :src="c.img" :alt="c.label" />
          </span>
          <span class="cat-text">{{ c.label }}</span>
        </button>
      </section>

      <!-- 推薦商品 -->
      <section class="recommend-cards">
        <h3 class="sec-title">You may Like</h3>
        <div class="card-row">
          <article v-for="p in cards" :key="p.id" class="card">
            <div class="card-inner">
              <!-- 收藏按钮 -->
              <button
                class="fav"
                :aria-label="p.liked ? 'unlike' : 'like'"
                @click="toggleFav(p)"
              >
                {{ p.liked ? '❤️' : '🤍' }}
              </button>

              <!-- 商品缩略图 -->
              <div class="thumb">
                <img :src="p.img" :alt="p.name" />
              </div>

              <!-- 價格標籤 -->
              <div class="price">{{ p.price }}</div>

              <!-- 名稱標籤 -->
              <div class="name">{{ p.name }}</div>
            </div>
          </article>
        </div>
      </section>
    </section>
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import Drawer from '../components/Drawer.vue'

// Drawer 控制
const drawerOpen = ref(false)
function toggleDrawer() {
  drawerOpen.value = !drawerOpen.value
}

// 推薦商品數據
const cards = ref([
  { id: 1, name: 'Book A', img: '/university.png', price: '$10.00', liked: false },
  { id: 2, name: 'Shoes', img: '/sports.png', price: '$25.00', liked: false },
  { id: 3, name: 'Laptop', img: '/tech.png', price: '$800.00', liked: false },
])

function toggleFav(p) {
  p.liked = !p.liked
}

// 分類按鈕
const cats = [
  { key: 'univ', label: 'university', img: '/university.png' },
  { key: 'tech', label: 'tech', img: '/tech.png' },
  { key: 'clothes', label: 'clothes', img: '/clothes.png' },
  { key: 'sports', label: 'sports', img: '/sports.png' },
  { key: 'living', label: 'living', img: '/living.png' },
  { key: 'other', label: 'others', img: '/others.png' },
]

function goCategory(c) {
  console.log('go category:', c)
}

onMounted(() => {
  console.log('Home mounted')
})
</script>

<style scoped>
.page-container {
  position: relative;
  min-height: 100vh;
  background: #f6f8fa;
}

/* 頂部導航 */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #0f1540;
  color: #fff;
  padding: 10px 16px;
}
.logo {
  font-size: 20px;
  font-weight: bold;
}
.menu-btn {
  background: transparent;
  border: none;
  font-size: 22px;
  color: #fff;
  cursor: pointer;
}

/* 內容區 */
.content {
  padding: 20px;
}

/* 分類區 */
.quick-cats {
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 12px;
  padding: 8px 0 16px;
}
.cat-btn {
  cursor: pointer;
  border: none;
  background: var(--nav-bg, #0f1540);
  color: #fff;
  border-radius: 12px;
  width: 110px;
  height: 110px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.cat-icon {
  width: 48px;
  height: 48px;
  border-radius: 10px;
  margin-bottom: 6px;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}
.cat-icon img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.cat-text {
  font-size: 13px;
}

/* 推薦卡片 */
.recommend-cards h3 {
  margin: 8px 0 14px;
  font-size: 18px;
}
.card-row {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 22px;
}
.card {
  background: #d6dfe3;
  border-radius: 22px;
  padding: 14px;
  box-shadow: 0 6px 12px rgba(16, 24, 40, 0.12);
}
.card-inner {
  position: relative;
  background: #fff;
  border-radius: 12px;
  height: 200px;
  overflow: hidden;
  --namebar-h: 56px;
}
.thumb {
  height: 150px;
  background: #ffffff;
}
.thumb img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.fav {
  position: absolute;
  top: 10px;
  right: 10px;
  border: none;
  background: #fff;
  border-radius: 999px;
  width: 32px;
  height: 32px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
  cursor: pointer;
}
.price {
  position: absolute;
  left: 12px;
  bottom: calc(var(--namebar-h) + 12px);
  background: #080808;
  color: #fff;
  border-radius: 999px;
  padding: 6px 10px;
  font-size: 12px;
  font-weight: 700;
}
.name {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  height: var(--namebar-h);
  background: #0f1540;
  color: #fff;
  padding: 12px 16px;
  font-weight: 700;
  display: flex;
  align-items: center;
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.25);
}
</style>

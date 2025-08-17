<template>
  <main class="page-container">
    <!-- 搜尋下方：推薦連結/快捷導覽（示例） -->
    <section class="recommend-row">
      <a v-for="l in rec" :key="l.text" class="rec-link" :href="l.href">
        {{ l.text }}
      </a>
    </section>

    <!-- 分類按鈕（從 Navbar 移過來） -->
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

    <!-- 下方保留你的首頁其他內容 -->
    <h2 style="margin: 20px 0 8px;">University</h2>
    <p style="color:#666">（這裡先放占位內容，你之後替換為實際版面）</p>

    <!-- you may like -->
    <section class = "recommend-cards">
      <h3 class="sec-title">You may Like</h3>
      <div class = "card-row"> 
        <article v-for =  "p in cards" :key = "p.id" class = "card">
          <div class = "card-inner">
            <button class = "fav" :aria-label="p.liked ? 'unlike' : 'like'" @click="toggleFav(p)">
          {{ p.liked ? '❤️' : '🤍' }}
          </button>
          <div class = "thumb">
            <img :src="p.img" :alt="p.name"/>
          </div>
          <div class = "price">{{ p.price }}</div>
          <div class = "name">{{ p.name }}</div>
          </div>   
        </article>
      </div>
    </section>
  </main>

    <!-- 底部半圆形装饰图案 -->
  <div class = "bottom-decor">
    <div class = "semi-circle"></div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Cats：使用 public 下的圖片
const cats = [
  { key: 'univ',   label: 'university', img: '/university.png' },
  { key: 'tech',   label: 'tech',       img: '/tech.png' },
  { key: 'clothes',label: 'clothes',    img: '/clothes.png' },
  { key: 'sports', label: 'sports',     img: '/sports.png' },
  { key: 'living', label: 'living',     img: '/living.png' },
  { key: 'other',  label: 'others',      img: '/others.png' },
]

function goCategory(c) {
  // 之後改成實際路由
  console.log('go category:', c)
}

// "you may like" 卡片数据（占位）
const cards = reactive([
  { id: 1, name: 'Product 1', price: '$10', img:'/1.jpg', liked: false },
  { id: 2, name: 'Product 2', price: '$20', img:'/2.jpg',liked: false },
  { id: 3, name: 'Product 3', price: '$30', img:'/3.jpg',liked: false },
  { id: 4, name: 'Product 4', price: '$40', img:'/1.jpg',liked: false },
  { id: 5, name: 'Product 5', price: '$50', img:'/2.jpg',liked: false },
  { id: 6, name: 'Product 6', price: '$60', img:'/3.jpg',liked: false },
])

function toggleFav(p) {
  p.liked = !p.liked
}
</script>

<style scoped>
/* 推薦連結列（搜尋下面） */
.recommend-row {
  display:flex; flex-wrap:wrap; gap:14px;
  margin: 10px 0 16px;
}
.rec-link {
  color:#0f1540; text-decoration:none; font-weight:600;
  padding: 6px 8px; border-radius:8px;
}
.rec-link:hover { background:#eef1f6; }

/* Quick categories（沿用你原本樣式） */
.quick-cats {
  display:grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap:12px;
  padding: 8px 0 16px;  /* 這裡不需要左右 padding，由 page-container 控制 */
}

.cat-btn {
  cursor:pointer; border:none; background:var(--nav-bg); color:#fff;
  border-radius:12px; width:110px; height:110px;   /* 正方形 */
  display:flex; flex-direction:column; align-items:center; justify-content:center;
  transition: transform .08s ease;
}

.cat-btn:active { transform: scale(.98); }
.cat-icon {
  width:48px; height:48px; border-radius:10px; margin-bottom:6px; overflow:hidden;
  display:flex; align-items:center; justify-content:center;
}
.cat-icon img { width:100%; height:100%; object-fit:cover; }
.cat-text { font-size:13px; }

/* RWD：小螢幕改 3 欄 */
@media (max-width: 768px) {
  .quick-cats { grid-template-columns: repeat(3, 1fr); }
  .cat-btn { width:100%; height:100px; }
}

/* You may like cards */
.recommend-cards h3{margin:8px 0 14px;font-size: 18px}
.card-row{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:22px}
.card {
  background: #d6dfe3;           /* 浅灰框色 */
  border-radius: 22px;           /* 大圆角 */
  padding: 14px;                 /* 留出内距形成“内框” */
  box-shadow: 0 6px 12px rgba(16,24,40,.12);
}

.card-inner {
  position: relative;
  background: #fff;
  border-radius: 12px;
  height: 200px;                 /* 可按需要调整高度 */
  overflow: hidden;
  --namebar-h: 56px;         /* ✅ 明确名称条高度（关键） */
}
/* 背景图 */
.thumb{height:150px;background:#ffffff}
.thumb img{ width:100%; height:100%; object-fit:cover; }
.fav{position:absolute;top:10px;right:10px;border:none;background:#fff;border-radius:999px;width:32px;height:32px;box-shadow:0 2px 6px rgba(0,0,0,.15);cursor:pointer}
.price{
  position:absolute;
  left:12px;
  bottom:calc(var(--namebar-h) + 12px); /* ✅ 用变量计算，永不跑偏 */
  background:#080808; color:#fff;
  border-radius:999px; padding:6px 10px; font-size:12px; font-weight:700;
  z-index:2;
}

.name{
  position: absolute;
  left: 0; right: 0; bottom: 0;
  height: var(--namebar-h);
  background: #0f1540;
  color: #fff;
  padding: 12px 16px;
  font-weight: 700;
  display: flex; align-items: center;
  box-shadow: 0 3px 8px rgba(0,0,0,.25);
}

</style>

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
  </main>
</template>

<script setup>
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
</style>

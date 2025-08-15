<template>
  <main style="padding:16px">
    <h2 style="margin:8px 0 4px;">University</h2>
    <p style="color:#666">（這裡先放占位內容，你之後替換為實際版面）</p>

    <h2 style="margin:24px 0 8px;">You May Like</h2>
    <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(220px,1fr)); gap:12px;">
      <div v-for="i in 6" :key="i" style="border:1px solid #e6e8ee; border-radius:12px; padding:12px; min-height:120px;">
        Card #{{ i }}
      </div>
    </div>
  </main>
</template>

<script setup>
// 先留空，之後接 API 或狀態管理
</script>

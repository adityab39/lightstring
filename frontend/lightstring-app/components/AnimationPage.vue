<template>
  <div class="animation-container">
    <button @click="$emit('back')">⬅ Back</button>
    <div class="gif-row">
      <img
        v-for="(url, index) in gifUrls"
        :key="index"
        :src="url"
        alt="Crystal Letter"
        class="gif-image"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: ['gifUrls'], // ← Pass directly from route or parent
};
</script>

<style scoped>
.animation-container {
  padding: 2rem;
  background: #0f1629;
  color: white;
}

.gif-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 1rem;
}

.gif-image {
  width: 150px;
  height: auto;
  border: 1px solid #fff;
  padding: 10px;
  background-color: white;
  border-radius: 10px;
}
</style>
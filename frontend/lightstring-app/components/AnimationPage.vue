<template>
  <div class="animation-page-wrapper">
    <button @click="$emit('back')" class="back-button">⬅ Back</button>

    <div class="scroll-track-container">
      <div class="gif-scroll-row">
        <img
          v-for="(url, index) in gifUrls"
          :key="index"
          :src="url"
          alt="Crystal Letter"
          class="gif-image"
        />
      </div>
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

.animation-page-wrapper {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 100vh;
  background: #0f1629;
  padding: 2rem;
  color: white;
}

.scroll-track-container {
  flex-grow: 1;
  display: flex;
  align-items: center; /* ← Center vertically */
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  width: 100%;
  padding-bottom: 1rem;
}

.gif-scroll-row {
  display: flex;
  align-items: center; /* ← Center vertically */
  gap: 1rem;
  padding: 1rem 0;
}

.gif-image {
  width: 400px;
  height: auto;
  flex-shrink: 0;
  border: 1px solid #fff;
  padding: 10px;
  background-color: white;
  border-radius: 10px;
}
</style>
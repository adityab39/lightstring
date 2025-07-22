<template>
  <div class="animation-container">
    <button @click="$emit('back')">⬅ Back</button>
    <div class="letter-animation" v-for="(char, index) in animationData" :key="index">
      <img :ref="el => imageRefs[index] = el" />
    </div>
  </div>
</template>

<script>
export default {
  props: ['animationData', 'colormap'],
  data() {
    return {
      imageRefs: [],
      baseURL: 'https://lightstring-images.s3.amazonaws.com/String_images/',
      frameDelay: 50,
    };
  },
  mounted() {
      this.$nextTick(() => {
    this.startAnimation();
  });
  },
  methods: {
    startAnimation() {
      this.animationData.forEach((charData, index) => {
        const frames = charData.map(name => this.baseURL + name);
        let i = 0;
        setInterval(() => {
          if (this.imageRefs[index]) {
            this.imageRefs[index].src = frames[i];
            i = (i + 1) % frames.length;
          }
        }, this.frameDelay); // 10 fps
      });
    },
  }
};
</script>

<style scoped>
.animation-container {
  padding: 2rem;
  background: #0f1629;
  color: white;
}
.letter-animation {
  display: inline-block;
  margin: 10px;
}
</style>
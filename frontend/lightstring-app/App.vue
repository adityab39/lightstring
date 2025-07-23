// App.vue
<template>
  <div>
    <HomePage
      v-if="!showAnimationPage"
      :userInput="userInput"
      :colors="colors"
      :selectedColormap="selectedColormap"
      @updateUserInput="userInput = $event"
      @colormapSelected="applyColormap"
      @generateClicked="generate"
    />

    <AnimationPage
      v-else
      :gifUrls="animationData"
      :userInput="userInput"
      :colormap="selectedColormap"
      :baseURL="baseURL"
      @back="goBack"
    />
  </div>
</template>

<script>
import HomePage from './components/HomePage.vue';
import AnimationPage from './components/AnimationPage.vue';

export default {
  components: { HomePage, AnimationPage },
  data() {
    return {
      userInput: "",
      selectedColormap: null,
      animationData: [],
      showAnimationPage: false,
      apiURL: "https://xgnwvafwj0.execute-api.us-east-2.amazonaws.com/prod/generate",
      baseURL: "https://lightstring-images.s3.amazonaws.com/String_images/",
      colors: ['Greys', 'Purples', 'Blues', 'Greens', 'Oranges', 'Reds'],
    };
  },
  methods: {
    async generate() {
      if (!this.selectedColormap || !this.userInput) return;
      try {
        const response = await fetch(this.apiURL, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            input: this.userInput,
            colormap: this.selectedColormap,
          }),
        });

        const data = await response.json();
        const gifUrls = data;

        this.animationData = gifUrls; 
        this.showAnimationPage = true;
      } catch (err) {
        console.error("Error fetching GIF URLs:", err);
      }
    },
    applyColormap(color) {
      this.selectedColormap = color;
    },
    goBack() {
      this.showAnimationPage = false;
    },
  },
};
</script>
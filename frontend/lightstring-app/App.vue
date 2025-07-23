// App.vue
<template>
  <div>
    <HomePage
      v-if="!showAnimationPage"
      :userInput="userInput"
      :colors="colors"
      :selectedColormap="selectedColormap"
      :errorMessage="errorMessage"
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
      apiURL: import.meta.env.VITE_API_URL,
      baseURL: import.meta.env.VITE_BASE_URL,
      colors: [
        { label: 'Grey', value: 'Greys', cssClass: 'grey' },
        { label: 'Purple', value: 'Purples', cssClass: 'purple' },
        { label: 'Blue', value: 'Blues', cssClass: 'blue' },
        { label: 'Green', value: 'Greens', cssClass: 'green' },
        { label: 'Orange', value: 'Oranges', cssClass: 'orange' },
        { label: 'Red', value: 'Reds', cssClass: 'red' }
      ],
      errorMessage: ''
    };
  },
  methods: {
    async generate() {
      this.errorMessage = ''; 

      if (!this.selectedColormap) {
        this.errorMessage = 'Please select a color.';
        return;
      }

      if (!this.userInput.trim()) {
        this.errorMessage = 'Please enter a string.';
        return;
      }

      if (!/^[a-zA-Z]+$/.test(this.userInput)) {
        this.errorMessage = 'Please enter alphabetic characters (A-Z, a-z) only.';
        return;
      }

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
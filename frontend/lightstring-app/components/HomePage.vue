<template>
  <div>
    <header>
      <div class="logo">LightString</div>
      <nav class="nav-links">
        <a href="#" class="nav-link active">Home</a>
      </nav>
    </header>

    <main>
      <h1>Create beautiful text with <span>Crystal Letters</span></h1>

      <p class="choose-color-text">Choose a Color</p>

      <button
        v-for="color in colors"
        :key="color"
        :class="['colormap-button', color.toLowerCase(), { selected: selectedColormap === color }]"
        @click="$emit('colormapSelected', color)"
      >
        {{ color }}
      </button>

      <div class="input-box">
        <input :value="userInput" @input="$emit('updateUserInput', $event.target.value)" placeholder="Type your string (A-Z only)" />
        <button @click="$emit('generateClicked')">Generate</button>
      </div>

      <div class="quick-try">Click Generate to see your crystal string ✨</div>


    </main>
  </div>
</template>

<script>
export default {
  props: ['userInput', 'colors', 'selectedColormap']
};
</script>
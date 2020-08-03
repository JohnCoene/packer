<template>
  <p>{{ greeting }} powered by Vue!</p>
</template>

<script>
module.exports = {
  data: function() {
    return {
      greeting: "Shiny"
    };
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

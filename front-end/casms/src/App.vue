<template>
  <div id="app">
    <!--    <router-link to="login">登录</router-link>-->
    <router-view></router-view>
  </div>
</template>

<script>
import Index from './views/login/Index.vue'


export default {
  name: 'App',
  components: {
    // eslint-disable-next-line vue/no-unused-components
    Index
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 0px;
  /*background-image: linear-gradient(to top, lightskyblue,peachpuff);*/
  background-color: whitesmoke;
}
</style>

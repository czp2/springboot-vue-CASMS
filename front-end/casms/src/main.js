import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import Cookies from 'js-cookie'
import './axios'
import Router from 'vue-router'
import * as echarts from 'echarts';

Vue.prototype.$axios = axios
Vue.prototype.$Cookies = Cookies
Vue.prototype.$echarts = echarts

Vue.config.devtools = true
Vue.config.productionTip = false
Vue.use(ElementUI)

const originalPush = Router.prototype.push
Router.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

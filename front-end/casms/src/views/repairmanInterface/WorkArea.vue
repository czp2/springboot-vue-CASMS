<template>
  <el-container style="height:100vh;">
    <el-container>
      <el-header style="height: 60px;">
        <el-menu
            default-active="1"
            class="el-menu-vertical-demo"
            mode="horizontal"
            text-color="black"
            active-text-color="cadetblue">
          <el-menu-item index="1" @click="newOrders">
            <i class="el-icon-thumb"></i>
            <span slot="title">可接订单</span>
          </el-menu-item>
          <el-menu-item index="2" @click="receivedOrders">
            <i class="el-icon-date"></i>
            <span slot="title">已接订单</span>
          </el-menu-item>
          <el-menu-item index="3" @click="processedOrders">
            <i class="el-icon-document-checked"></i>
            <span slot="title">已处理订单</span>
          </el-menu-item>
          <el-menu-item index="4" @click="completedOrders">
            <i class="el-icon-circle-check"></i>
            <span slot="title">已完成订单</span>
          </el-menu-item>
        </el-menu>
      </el-header>

      <el-container>
        <router-view></router-view>
      </el-container>
    </el-container>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
    };
  },
  created() {
  },
  methods: {
    logout() {
      this.$router.push({path: '/'})
    },
    newOrders() {
      this.$router.push({path: '/workArea/newOrders'})
    },
    receivedOrders() {
      this.$router.push({path: '/workArea/receivedOrders'})
    },
    processedOrders() {
      this.$router.push({path: '/workArea/processedOrders'})
    },
    completedOrders() {
      this.$router.push({path: '/workArea/completedOrders'})
    },
  }
}
</script>

<style scoped>
.el-header {
  background-color: #B3C0D1;
  color: #333;
  line-height: 60px;
}

.el-aside {
  color: #333;
}
</style>

<template>
  <el-container>
    <el-container>
      <el-header style="height: 60px;background-color: #2f3542">
        <el-menu
            default-active="1"
            class="el-menu-vertical-demo"
            mode="horizontal"
            text-color="black"
            background-color="#2f3542"
            active-text-color="#ffd04b">
          <el-menu-item index="1" @click="testEcharts">
            <span slot="title">电脑维修次数统计</span>
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
import repairReview from "@/views/manage/review/RepairReview";
import roleReview from "@/views/manage/review/RoleReview";

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
    testEcharts() {
      this.$router.push({path: '/echarts/test'})
    },
    repairReview() {
      this.$router.push({path: '/echarts/test'})
    },
    roleReview() {
      this.$router.push({path: '/echarts/test'})
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

<template>
  <el-container>
    <el-container>
      <el-header style="height: 60px;background-color: whitesmoke">
        <el-menu
            default-active="1"
            class="el-menu-vertical-demo"
            mode="horizontal"
            text-color="black"
            active-text-color="cadetblue">
          <el-menu-item index="1" @click="problemReview">
            <i class="el-icon-chat-line-round"></i>
            <span slot="title">问题审核</span>
          </el-menu-item>
          <el-menu-item index="2" @click="repairReview">
            <i class="el-icon-date"></i>
            <span slot="title">维修订单审核</span>
          </el-menu-item>
          <el-menu-item index="3" @click="roleReview">
            <i class="el-icon-s-custom"></i>
            <span slot="title">角色审核（普通用户申请成为维修员）</span>
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
    problemReview() {
      this.$router.push({path: '/review/problemReview'})
    },
    repairReview() {
      this.$router.push({path: '/review/repairReview'})
    },
    roleReview() {
      this.$router.push({path: '/review/roleReview'})
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

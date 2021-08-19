<template>
  <el-container>
    <el-header style="width: 100%;background-color:cadetblue;height: 50px;">
      <div style="line-height: 50px">
        <el-button size="mini" icon="el-icon-arrow-left" @click="back">返回</el-button>
      </div>
    </el-header>
    <el-container style="height: 100vh;">
      <el-aside width="20%" style="text-align:center;height: 100vh;overflow-y: hidden;background-color: #80b4b7">
        <div style="width: 100%;display:inline-block;">
          <div style="text-align: center;margin-top: 20px">
            <Avatar  :username="realname"
                     :src="avator"
                     background-color="white"
                     color="cadetblue"
                     style="vertical-align: middle;width: 100px;height: 100px"
                     :inline="true">
            </Avatar>
          </div>
          <div style="width: 100%;">
            <el-menu
                style="margin-top: 50px;"
                default-active="1"
                class="el-menu-vertical-demo"
                background-color="#80b4b7"
                text-color="#fff"
                active-text-color="#ffd04b">
              <el-menu-item index="1" @click="toPersonalInfo">
                <i class="el-icon-info"></i>
                <span>个人信息</span>
              </el-menu-item>
              <el-menu-item index="2" @click="toMyQuestion">
                <i class="el-icon-chat-line-round"></i>
                <span>我的提问</span>
              </el-menu-item>
              <el-menu-item index="3" @click="toMyRepairOrder">
                <i class="el-icon-shopping-cart-1"></i>
                <span>我的维修</span>
              </el-menu-item>
              <el-menu-item index="4" @click="toFeedback">
                <i class="el-icon-message"></i>
                <span>我的反馈</span>
              </el-menu-item>
            </el-menu>
          </div>
          <div style="padding: 20px">
          </div>
        </div>
      </el-aside>
      <el-main style="text-align:center;height: 100vh;">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Avatar from 'vue-avatar'

export default {
  components:{Avatar},
  data() {
    return {
      realname: this.$store.getters.getUser.realname,
      avator: this.$store.getters.getUser.avator,
    };
  },
  created() {
  },
  methods: {
    toMyQuestion() {
      this.$router.push({path: '/personal/myProblem'})
    },
    toMyRepairOrder() {
      this.$router.push({path: '/personal/myRepairOrder'})
    },
    toFeedback(){
      this.$router.push({path: '/personal/feedback'})
    },
    toPersonalInfo(){
      this.$router.push({path: '/personal/personalInfo'})
    },
    back() {
      if(this.$store.getters.getUser.role==="普通用户"){
        this.$router.push("/userInterface/homePage")
      }else if(this.$store.getters.getUser.role==="维修人员"){
        this.$router.push("/repairmanInterface/homePage")
      }
    },
  }
};
</script>

<style scoped>

</style>

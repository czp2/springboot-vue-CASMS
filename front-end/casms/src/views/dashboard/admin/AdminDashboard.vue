<template>
  <el-container style="height:100vh;">
    <el-header style="background-color: #545c64;">
      <el-image
          style="width: 240px; height: 60px;float: left"
          :src="backendLogo"
          fit="fit"></el-image>
      <div style="float: right">
        <el-tooltip content="点击管理个人信息" placement="bottom">
          <el-avatar
              shape="square"
              fit="cover"
              style="margin-top: 10px;"
              src="https://iconfont.alicdn.com/t/a1d1d4e6-4ff3-4b25-80fd-2720cc65b11f.png"
              @click.native="drawer = true"
          ></el-avatar>
        </el-tooltip>
      </div>
    </el-header>

    <el-container>
      <el-aside style="width: auto;background-color: #34495e;padding: 10px;">
        <el-menu
            default-active="1"
            class="el-menu-vertical-demo"
            background-color="#34495e"
            text-color="#fff"
            active-text-color="#ffd04b">
          <el-menu-item index="1" @click="toReview">
            <i class="el-icon-s-claim"></i>
            <span slot="title">审核中心</span>
          </el-menu-item>
          <el-menu-item index="2" @click="toUserManage">
            <i class="el-icon-s-custom"></i>
            <span slot="title">用户管理</span>
          </el-menu-item>
          <el-menu-item index="3" @click="toProblemManage">
            <i class="el-icon-chat-dot-square "></i>
            <span slot="title">问题管理</span>
          </el-menu-item>
          <el-menu-item index="4" @click="toRepairManage">
            <i class="el-icon-setting"></i>
            <span slot="title">维修管理</span>
          </el-menu-item>
          <el-menu-item index="5" @click="toEcharts">
            <i class="el-icon-pie-chart"></i>
            <span slot="title">数据统计</span>
          </el-menu-item>
          <el-menu-item index="6" @click="toFeedbackManage">
            <i class="el-icon-news"></i>
            <span slot="title">反馈中心</span>
          </el-menu-item>
        </el-menu>
      </el-aside>

      <el-container>
        <router-view></router-view>
      </el-container>
    </el-container>

    <el-drawer
        title="个人信息"
        :visible.sync="drawer"
    >
      <div style="text-align: center">
        <el-avatar
            shape="circle"
            :size="150"
            fit="cover"
            style="margin-top: 15px;"
            src="https://iconfont.alicdn.com/t/a1d1d4e6-4ff3-4b25-80fd-2720cc65b11f.png"
        ></el-avatar>
      </div>
      <div style="padding: 20px">
        <el-form>
          <el-form-item>
            <el-input v-model="myData.userName" :disabled="isDisabled">
              <template slot="prepend">账户昵称</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.realname" :disabled="isDisabled">
              <template slot="prepend">真实姓名</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.email" :disabled="isDisabled">
              <template slot="prepend">账户邮箱</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.userPwd" :disabled="isDisabled">
              <template slot="prepend">账户密码</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.address" :disabled="isDisabled">
              <template slot="prepend">联系地址</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.tel" :disabled="isDisabled">
              <template slot="prepend">联系方式</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.createTime" disabled>
              <template slot="prepend">注册时间</template>
            </el-input>
          </el-form-item>
        </el-form>
      </div>
      <div style="text-align: center;margin-bottom: 20px;" v-show="isUpdateOn">
        <el-button type="primary" style="width:90%;" @click="updateMyInfo">确认修改</el-button>
      </div>
      <div style="text-align: center;">
        <el-button type="primary" style="width:90%;" @click="upDateOn">修改信息</el-button>
      </div>
      <div style="text-align: center;margin-top: 20px;margin-bottom: 40px">
        <el-button type="danger" style="width:90%;" @click="logout">退出登录</el-button>
      </div>
    </el-drawer>
  </el-container>
</template>

<script>
export default {
  name: "adminIndex",
  data() {
    return {
      logo: require('/src/assets/casms-logo.png'),
      backendLogo: require('/src/assets/casms-backend-logo.png'),
      isDisabled: true,
      isUpdateOn: false,
      myData: {},
      drawer: false,
    };
  },
  created() {
    this.getMyInfo();
  },
  methods: {
    logout() {
      this.$router.push({path: '/'})
    },
    toReview() {
      this.$router.push({path: '/review/problemReview'})
    },
    toUserManage() {
      this.$router.push({path: '/manage/user'})
    },
    toProblemManage() {
      this.$router.push({path: '/manage/problem'})
    },
    toRepairManage() {
      this.$router.push({path: '/manage/repair'})
    },
    toFeedbackManage() {
      this.$router.push({path: '/manage/feedbackManage'})
    },
    toEcharts(){
      this.$router.push({path: '/echarts/test'})
    },
    getMyInfo() {
      this.$axios.post('http://localhost:8080/user/getUserById?id=' + this.$store.getters.getUserId).then(resp => {
        this.myData = resp.data.data
      })
    },
    updateMyInfo() {
      this.$axios.put('http://localhost:8080/user/userInfoSet', this.myData).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '修改成功!'
          });
          this.$router.go(0)
        }
        this.upDateOn()
      })
    },
    upDateOn() {
      this.isDisabled = !this.isDisabled
      this.isUpdateOn = !this.isUpdateOn
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

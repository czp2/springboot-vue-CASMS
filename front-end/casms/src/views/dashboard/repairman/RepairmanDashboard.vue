<template>
  <el-container style="height: 2000px;display: flex;justify-content: center;align-items: center">
    <el-header style="width: 100%;background-color:cadetblue;height: 70px;">
      <el-image
          style="width: 80px; height: 60px;float: left;margin-left: 3%"
          :src="logo"
          fit="fit"></el-image>
      <el-menu
          default-active="1"
          class="el-menu-demo"
          mode="horizontal"
          background-color="cadetblue"
          text-color="#fff"
          style="width: 400px;float: left;border: 2px cadetblue solid;margin-left: 50px"
          active-text-color="#ffd04b">
        <el-menu-item index="1" @click="toHomePage">首页</el-menu-item>
        <el-menu-item index="2" @click="toWorkArea">工作区</el-menu-item>
      </el-menu>

      <div style="width: 120px;float: right;margin-right: 3%">
        <div style="float:left;margin-top: 6px">
          <el-tooltip content="反馈与建议" placement="bottom">
            <el-button type="warning" icon="el-icon-service" circle @click="dialogFormVisible=true"></el-button>
          </el-tooltip>
        </div>
        <el-tooltip content="点击管理个人信息" placement="bottom">
          <div style="float:right;">
            <Avatar  :username="realname"
                     :src="avator"
                     background-color="white"
                     color="cadetblue"
                     style="vertical-align: middle;margin-top: 5px"
                     :inline="true"
                     @click.native="toPersonal">
            </Avatar>
          </div>
        </el-tooltip>
      </div>
    </el-header>

    <el-container style="width: 80%;height: 100vh;margin-top: 20px">
      <router-view style="height: 100vh;"></router-view>
    </el-container>

    <el-footer style="width: 100%;text-align: center;background-color: cadetblue;height: 200px;">

    </el-footer>

    <el-dialog :visible.sync="dialogFormVisible" width="40%" title="反馈与建议">
      <el-form ref="form" :model="feedbackForm" label-width="80px">
        <el-form-item label="类别">
          <el-select v-model="feedbackForm.type" placeholder="请选择">
            <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="内容">
          <el-input type="textarea" :rows="5" v-model="feedbackForm.content"></el-input>
        </el-form-item>
        <el-form-item size="large">
          <el-button type="primary" @click="createFeedback">立即创建</el-button>
          <el-button @click="dialogFormVisible=false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
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
      logo: require('/src/assets/casms-logo.png'),
      dialogFormVisible: false,
      feedbackForm: {
        userId: this.$store.getters.getUserId,
        type: '',
        content: '',
      },
      options: [{
        value: '系统方面',
        label: '系统方面'
      }, {
        value: '服务方面',
        label: '服务方面'
      }, {
        value: '给个鼓励',
        label: '给个鼓励'
      },],
    };
  },
  created() {
  },
  methods: {
    toWorkArea() {
      this.$router.push({path: '/workArea/newOrders'})
    },
    toHomePage() {
      this.$router.push({path: '/repairmanInterface/homePage'})
    },
    toPersonal(){
      this.$router.push({path: '/personal/personalInfo'})
    },
    createFeedback(){
      this.$axios.post('http://localhost:8080/feedback/create', this.feedbackForm).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: resp.data.msg
          });
          this.dialogFormVisible = false
        }
      })
    }
  }
};
</script>

<style>
.el-header {
  background-color: #B3C0D1;
  color: #333;
  line-height: 60px;
}

.el-drawer__header {
  height: 30px;
  background: lightblue;
}

.el-drawer__body {
  overflow: auto;
  height: 0;
}

.el-drawer__container ::-webkit-scrollbar {
  display: none;
}
</style>

<!--<template>-->
<!--  <el-container style="height: 2000px;display: flex;justify-content: center;align-items: center">-->
<!--    <el-header style="width: 100%;background-color:cadetblue;height: 70px;">-->
<!--      <el-image-->
<!--          style="width: 140px; height: 60px;float: left;margin-left: 3%"-->
<!--          :src="logo"-->
<!--          fit="fit"></el-image>-->
<!--      <el-menu-->
<!--          default-active="1"-->
<!--          class="el-menu-demo"-->
<!--          mode="horizontal"-->
<!--          background-color="cadetblue"-->
<!--          text-color="#fff"-->
<!--          style="float: left;border: 2px cadetblue solid"-->
<!--          active-text-color="#ffd04b">-->
<!--        <el-menu-item index="1" @click="toHomePage">首页</el-menu-item>-->
<!--        <el-menu-item index="2" @click="toWorkArea">工作区</el-menu-item>-->
<!--        <el-menu-item index="3" @click="toMyQuestion">我的提问</el-menu-item>-->
<!--        <el-menu-item index="4" @click="toMyRepairOrder">我的维修</el-menu-item>-->
<!--        <el-menu-item index="5" @click="toFeedback">我的反馈</el-menu-item>-->
<!--      </el-menu>-->

<!--      <div style="width: 120px;float: right">-->
<!--        <div style="float:left;margin-top: 6px">-->
<!--          <el-tooltip content="反馈与建议" placement="bottom">-->
<!--            <el-button type="warning" icon="el-icon-service" circle @click="dialogFormVisible=true"></el-button>-->
<!--          </el-tooltip>-->
<!--        </div>-->
<!--        <el-tooltip content="点击管理个人信息" placement="bottom">-->
<!--          <div style="float:right;">-->
<!--            <el-avatar-->
<!--                shape="square"-->
<!--                fit="cover"-->
<!--                style="margin-top: 15px;"-->
<!--                src="https://iconfont.alicdn.com/t/1659096d-410f-40b1-a5e4-f71934c32d5f.png"-->
<!--                @click.native="drawer = true"-->
<!--            ></el-avatar>-->
<!--          </div>-->
<!--        </el-tooltip>-->
<!--      </div>-->
<!--    </el-header>-->

<!--    <el-container style="width: 80%;height: 100vh;margin-top: 20px">-->
<!--      <router-view style="height: 100vh;"></router-view>-->
<!--    </el-container>-->

<!--    <el-footer style="width: 100%;text-align: center;background-color: cadetblue;height: 200px;">-->

<!--    </el-footer>-->

<!--    <el-drawer-->
<!--        title="个人信息"-->
<!--        :visible.sync="drawer"-->
<!--    >-->
<!--      <div style="text-align: center">-->
<!--        <el-avatar-->
<!--            shape="circle"-->
<!--            :size="150"-->
<!--            fit="cover"-->
<!--            style="margin-top: 15px;"-->
<!--            src="https://iconfont.alicdn.com/t/1659096d-410f-40b1-a5e4-f71934c32d5f.png"-->
<!--        ></el-avatar>-->
<!--      </div>-->
<!--      <div style="padding: 20px">-->
<!--        <el-form>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="myData.userName" :disabled="isDisabled">-->
<!--              <template slot="prepend">账户昵称</template>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="myData.realname" :disabled="isDisabled">-->
<!--              <template slot="prepend">真实姓名</template>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="myData.email" :disabled="isDisabled">-->
<!--              <template slot="prepend">账户邮箱</template>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="myData.userPwd" :disabled="isDisabled">-->
<!--              <template slot="prepend">账户密码</template>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="myData.address" :disabled="isDisabled">-->
<!--              <template slot="prepend">联系地址</template>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="myData.tel" :disabled="isDisabled">-->
<!--              <template slot="prepend">联系方式</template>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="myData.createTime" disabled>-->
<!--              <template slot="prepend">注册时间</template>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--        </el-form>-->
<!--      </div>-->
<!--      <div style="text-align: center;margin-bottom: 20px;" v-show="isUpdateOn">-->
<!--        <el-button type="primary" style="width:90%;" @click="updateMyInfo">确认修改</el-button>-->
<!--      </div>-->
<!--      <div style="text-align: center;">-->
<!--        <el-button type="primary" style="width:90%;" @click="upDateOn">修改信息</el-button>-->
<!--      </div>-->
<!--      <div style="text-align: center;margin-top: 20px;margin-bottom: 40px">-->
<!--        <el-button type="danger" style="width:90%;" @click="logout">退出登录</el-button>-->
<!--      </div>-->
<!--    </el-drawer>-->

<!--    <el-dialog :visible.sync="dialogFormVisible" width="40%" title="反馈与建议">-->
<!--      <el-form ref="form" :model="feedbackForm" label-width="80px">-->
<!--        <el-form-item label="类别">-->
<!--          <el-select v-model="feedbackForm.type" placeholder="请选择">-->
<!--            <el-option-->
<!--                v-for="item in options"-->
<!--                :key="item.value"-->
<!--                :label="item.label"-->
<!--                :value="item.value">-->
<!--            </el-option>-->
<!--          </el-select>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="内容">-->
<!--          <el-input type="textarea" :rows="5" v-model="feedbackForm.content"></el-input>-->
<!--        </el-form-item>-->
<!--        <el-form-item size="large">-->
<!--          <el-button type="primary" @click="createFeedback">立即创建</el-button>-->
<!--          <el-button @click="dialogFormVisible=false">取消</el-button>-->
<!--        </el-form-item>-->
<!--      </el-form>-->
<!--    </el-dialog>-->
<!--  </el-container>-->
<!--</template>-->

<!--<script>-->

<!--export default {-->
<!--  data() {-->
<!--    return {-->
<!--      logo: require('/src/assets/casms-logo.png'),-->
<!--      isDisabled: true,-->
<!--      isUpdateOn: false,-->
<!--      myData: {},-->
<!--      drawer: false,-->
<!--      dialogFormVisible: false,-->
<!--      feedbackForm: {-->
<!--        userId: this.$store.getters.getUserId,-->
<!--        type: '',-->
<!--        content: '',-->
<!--      },-->
<!--      options: [{-->
<!--        value: '系统方面',-->
<!--        label: '系统方面'-->
<!--      }, {-->
<!--        value: '服务方面',-->
<!--        label: '服务方面'-->
<!--      }, {-->
<!--        value: '给个鼓励',-->
<!--        label: '给个鼓励'-->
<!--      },],-->
<!--    };-->
<!--  },-->
<!--  created() {-->
<!--    this.getMyComputer();-->
<!--  },-->
<!--  methods: {-->
<!--    logout() {-->
<!--      this.$router.push({path: '/'})-->
<!--    },-->
<!--    toFeedback(){-->
<!--      this.$router.push({path: '/repairmanInterface/feedback'})-->
<!--    },-->
<!--    toMyQuestion() {-->
<!--      this.$router.push({path: '/repairmanInterface/myProblem'})-->
<!--    },-->
<!--    toMyRepairOrder() {-->
<!--      this.$router.push({path: '/repairmanInterface/myRepairOrder'})-->
<!--    },-->
<!--    getMyComputer() {-->
<!--      this.$axios.post('http://localhost:8080/user/getUserById?id=' + this.$store.getters.getUserId).then(resp => {-->
<!--        console.log(resp.data.data)-->
<!--        this.myData = resp.data.data-->
<!--      })-->
<!--    },-->
<!--    updateMyInfo() {-->
<!--      this.$axios.put('http://localhost:8080/user/userInfoSet', this.myData).then(resp => {-->
<!--        if (resp.data.code == 200) {-->
<!--          this.$message({-->
<!--            type: 'success',-->
<!--            message: '修改成功!'-->
<!--          });-->
<!--        }-->
<!--        this.upDateOn()-->
<!--      })-->
<!--    },-->
<!--    upDateOn() {-->
<!--      this.isDisabled = !this.isDisabled-->
<!--      this.isUpdateOn = !this.isUpdateOn-->
<!--    },-->
<!--    createFeedback(){-->
<!--      this.$axios.post('http://localhost:8080/feedback/create', this.feedbackForm).then(resp => {-->
<!--        if (resp.data.code == 200) {-->
<!--          this.$message({-->
<!--            type: 'success',-->
<!--            message: resp.data.msg-->
<!--          });-->
<!--          this.dialogFormVisible = false-->
<!--        }-->
<!--      })-->
<!--    }-->
<!--  }-->
<!--};-->
<!--</script>-->

<!--<style>-->
<!--.el-header {-->
<!--  background-color: #B3C0D1;-->
<!--  color: #333;-->
<!--  line-height: 60px;-->
<!--}-->

<!--.el-drawer__header {-->
<!--  height: 30px;-->
<!--  background: lightblue;-->
<!--}-->

<!--.el-drawer__body {-->
<!--  overflow: auto;-->
<!--  height: 0;-->
<!--}-->

<!--.el-drawer__container ::-webkit-scrollbar {-->
<!--  display: none;-->
<!--}-->
<!--</style>-->

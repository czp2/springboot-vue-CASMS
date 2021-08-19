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
    toHomePage() {
      this.$router.push({path: '/userInterface/homePage'})
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

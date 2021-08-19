<template>
  <el-container style="text-align: center;height: 100vh" :style="login">
    <div class="div-login">
      <div>
        <el-image
            :src="logo"
            fit="fit"></el-image>
      </div>
      <div class="div-text">
        <el-form ref="loginForm" :model="userLogin" :rules="loginRule" class="item">
          <el-form-item label="用户名或者邮箱地址" prop="userName">
            <el-input type="text" placeholder="请输入账号" v-model="userLogin.userName" clearable/>
          </el-form-item>
          <el-form-item label="密码" prop="userPwd" style="text-align: right" class="item">
            <el-input type="password" placeholder="请输入密码" v-model="userLogin.userPwd" show-password clearable/>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" style="width:100%;margin-top: 30px" @click="onSubmit('loginForm')">登录
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </el-container>
</template>

<script>
export default {
  name: "AdminLogin",
  data() {
    return {
      logo: require('/src/assets/casms-logo.png'),
      login:{
        backgroundImage: "url(" + require("/src/assets/space-adminLogin.png") + ")",
        backgroundSize: "cover"
      },
      userLogin: {userName: "", userPwd: "", role: "管理员"},
      //表单验证
      loginRule: {
        userName: [
          {required: true, message: '账号不可为空', trigger: 'blur'}
        ],
        userPwd: [
          {required: true, message: '密码不可为空', trigger: 'blur'}
        ],
        role: [
          {required: true, message: '请选择你的角色', trigger: 'blur'}
        ],
      },
    }
  },
  methods: {
    onSubmit(loginForm) {
      this.$refs[loginForm].validate((valid) => {
        if (valid) {
          this.$axios.post('http://localhost:8080/user/login', this.userLogin).then(resp => {
            if (resp.data.code === 200) {
              this.$store.commit('SET_USERINFO', resp.data.data)
              this.$message({
                type: 'success',
                message: resp.data.msg
              })
              this.$router.push('/review/problemReview')
            } else {
              this.$message({
                type: 'warning',
                message: resp.data.msg
              })
            }
          })
        } else {
          return false;
        }
      });
    }
  }
}
</script>

<style>
.div-login {
  width: 100%;
  height: 100%;
  text-align: center;
}

.div-text {
  display:inline-block;
  width: 30%;
  height: auto;
  padding: 20px 20px 0px 20px;
  border-radius: 5px;
  background-color:rgba(0,0,0,0.5);
}
</style>

<template>
  <el-container :style="login">
    <el-main style="text-align: center;height: 100vh;overflow-y: hidden">
      <div class="div-login">
        <div>
          <el-image
              :src="logo"
              fit="fit"></el-image>
        </div>

        <div style="display:inline-block;
                    width: 30%;
                    height: auto;
                    padding: 20px 20px 0px 20px;
                    border-radius: 5px;
                    background-color:rgba(0,0,0,0.5);">
          <el-form ref="loginForm" :model="userLogin" :rules="loginRule"  class="item">
            <el-form-item label="用户名或者邮箱地址" prop="userName">
              <el-input type="text" placeholder="请输入账号" v-model="userLogin.userName" size="small" clearable/>
            </el-form-item>
            <el-form-item label="密码" prop="userPwd" style="text-align: right">
              <el-input type="password" placeholder="请输入密码" v-model="userLogin.userPwd" size="small" show-password clearable/>
            </el-form-item>
            <el-form-item label="角色" prop="role">
              <el-radio-group v-model="userLogin.role" size="small">
                <el-radio value="普通用户" label="普通用户" border style="color: white"></el-radio>
                <el-radio value="维修人员" label="维修人员" border style="color: white"></el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" style="width:100%;" size="small" @click="onSubmit('loginForm')">登录
              </el-button>
            </el-form-item>
            <el-form-item>
              <label style="color: white">还没有账号？</label>
              <router-link to="register" type="primary" style="color: lightskyblue" disabled>立即注册</router-link>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </el-main>
    <el-footer style="text-align: center;margin-top: 50px">
      <div>
        <el-link style="color: mediumpurple" type="primary" disabled>联系我们</el-link>
        <label style="color: white;margin-left: 30px">copyright@uniqueczp</label>
        <label style="color: white;margin-left: 30px">版权所有</label>
      </div>
    </el-footer>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      logo: require('/src/assets/casms-logo.png'),
      login:{
        backgroundImage: "url(" + require("/src/assets/sapce-login.png") + ")",
        backgroundSize: "cover"
      },
      userLogin: {userName: "", userPwd: "", role: ""},
      //表单验证
      loginRule: {
        userName: [
          {required: true, message: '账号不可为空', trigger: 'blur'},
          { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
        ],
        userPwd: [
          {required: true, message: '密码不可为空', trigger: 'blur'},
          { min: 6, max: 16, message: '长度在 6 到 16 个字符', trigger: 'blur' }
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
              let userRole = this.$store.getters.getUser.role
              if(userRole == "普通用户"||userRole == "申请成为维修员"){
                this.$router.push({path: '/userInterface/homePage'})
              }else if(userRole == "维修人员"){
                this.$router.push({path: '/repairmanInterface/homePage'})
              }
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
.item .el-form-item__label{
  color: white;
}
.div-login {
  width: 100%;
  text-align: center;
}
.title {
  font-size: 26px;
  color: dodgerblue;
  margin: 0px auto 20px auto;
  text-align: center;
  font-weight: bold;
}
</style>

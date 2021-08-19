<template>
  <el-container style="height: 150vh;background-image: linear-gradient(to top, lightskyblue,peachpuff);">
    <el-main style="height: 100vh">
      <div class="div-bg">
        <div class="div-register">
          <div>
            <div>
              <h3 style="font-size: 12px">开始使用</h3>
            </div>
            <div>
              <h3 class="title">请创建您的账户</h3>
            </div>
          </div>
          <div style="padding: 20px 20px 0px 20px;">
            <el-form ref="registerForm" :model="register" :rules="rules">
              <el-form-item label="用户名" prop="userName">
                <el-input type="text" placeholder="请输入用户名" v-model="register.userName" clearable/>
              </el-form-item>
              <el-form-item label="邮箱" prop="email">
                <el-input placeholder="请输入邮箱" v-model="register.email" clearable/>
              </el-form-item>
              <el-form-item label="密码" prop="userPwd">
                <el-input type="password" placeholder="请输入密码" v-model="register.userPwd" show-password clearable/>
              </el-form-item>
              <el-form-item label="确认密码" prop="checkPass">
                <el-input type="password" placeholder="请再次输入密码" v-model="register.checkPass" autocomplete="off"
                          show-password clearable/>
              </el-form-item>
              <el-form-item>
                <el-button :loading="loading" type="primary" style="width:100%;"
                           @click="onSubmit('registerForm')">创建账户
                </el-button>
                <p style="font-size: 10px;line-height: 12px;text-align: left">创建帐户即表示您同意 服务条款。有关 Casms 的隐私惯例的更多信息，请参阅 Casms
                  隐私声明。我们有时会向您发送与帐户相关的电子邮件。</p>
              </el-form-item>
              <el-form-item>
                <el-button :loading="loading" type="primary" style="width:100%;" @click="returnLogin">
                    返回去登录
                </el-button>
              </el-form-item>
            </el-form>
          </div>
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
  name: "Register",
  data() {
    const validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.register.userPwd) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {
      register: {userName: '', userPwd: '', checkPass: '', email: ''},
      //表单验证
      rules: {
        userName: [
          {required: true, message: '账号不可为空', trigger: 'blur'},
          { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
        ],
        userPwd: [
          {required: true, message: '密码不可为空', trigger: 'blur'},
          { min: 8, max: 16, message: '长度在 8 到 16 个字符', trigger: 'blur' }
        ], email: [
          {required: true, message: '请输入邮箱地址', trigger: 'blur'},
          {type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change']}
        ], checkPass: [
          {required: true, validator: validatePass, trigger: 'blur',}
        ],
      },
    }
  },
  methods: {
    onSubmit(registerForm) {
      this.$refs[registerForm].validate((valid) => {
        if (valid) {
          this.$axios.post('http://localhost:8080/user/register',this.register).then(resp => {
            if (resp.data.code == 200) {
              this.$message({
                type: 'success',
                message: resp.data.msg
              })
            } else {
              this.$message({
                type: 'warning',
                message: resp.data.msg
              })
              return false;
            }
          })
        } else {
          return false;
        }
      });
    },returnLogin() {
      this.$router.push({path: '/login'})
    },
  }
}
</script>

<style>
.div-bg {
  width: auto;
  height: 500px;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 80px;
}

.div-register {
  width: 40%;
  text-align: center;
  justify-content: center;
  align-items: center;

}

.title {
  font-size: 26px;
  color: dodgerblue;
  margin: 0px auto 20px auto;
  text-align: center;
  font-weight: bold;
}

</style>

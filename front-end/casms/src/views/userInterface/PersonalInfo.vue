<template>
  <el-container style="display: inline-block;width: 100%;margin-top: 20px">
    <div style="width: 70%;display:inline-block;">
      <Avatar  :username="myData.realname"
               :src="myData.avator"
               background-color="cadetblue"
               color="white"
               style="vertical-align: middle;width: 100px;height: 100px"
               :inline="true">
      </Avatar>
      <div style="padding: 20px;margin-top: 40px">
        <el-form>
          <el-form-item style="float: left">
            <el-input v-model="myData.userName" :disabled="isDisabled" size="small">
              <template slot="prepend">账户昵称</template>
            </el-input>
          </el-form-item>
          <el-form-item style="float: right">
            <el-input v-model="myData.realname" :disabled="isDisabled" size="small">
              <template slot="prepend">真实姓名</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.email" :disabled="isDisabled" size="small">
              <template slot="prepend">账户邮箱</template>
            </el-input>
          </el-form-item>
          <el-form-item style="float: left">
            <el-input v-model="myData.userPwd" :disabled="isDisabled" size="small">
              <template slot="prepend">账户密码</template>
            </el-input>
          </el-form-item>
          <el-form-item style="float: right">
            <el-input v-model="myData.tel" :disabled="isDisabled" size="small">
              <template slot="prepend">联系方式</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.address" :disabled="isDisabled" size="small">
              <template slot="prepend">联系地址</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.createTime" disabled size="small">
              <template slot="prepend">注册时间</template>
            </el-input>
          </el-form-item>
        </el-form>
        <div style="text-align: center;margin-top: 20px;" v-show="isUpdateOn">
          <el-button type="warning" style="width:40%;float: left" size="small" @click="updateMyInfo">确认修改
          </el-button>
          <el-button type="primary" style="width:40%;float: right" size="small" @click="upDateOn">取消修改</el-button>
        </div>
      </div>
    </div>
    <div style="width: 15%;float: right;margin-top:40vh">
      <div style="text-align: center;">
        <el-button type="primary" style="width:90%;" size="small" @click="upDateOn">修改信息</el-button>
      </div>
      <div style="text-align: center;margin-top: 20px;" v-show="myData.role==='普通用户'">
        <el-button type="primary" style="width:90%;" size="small" @click="apply">申请成为维修员</el-button>
      </div>
      <div style="text-align: center;margin-top: 20px;margin-bottom: 40px">
        <el-button type="danger" style="width:90%;" size="small" @click="logout">退出登录</el-button>
      </div>
    </div>
  </el-container>
</template>

<script>
import Avatar from 'vue-avatar'

export default {
  components:{Avatar},
  data() {
    return {
      isDisabled: true,
      isUpdateOn: false,
      myData: {},
    };
  },
  created() {
    this.getMyInfo();
  },
  methods: {
    logout() {
      this.$router.push({path: '/'})
    },
    getMyInfo() {
      this.$axios.post('http://localhost:8080/user/getUserById?id=' + this.$store.getters.getUserId).then(resp => {
        this.myData = resp.data.data
      })
    },
    apply() {
      this.$confirm('确定吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        if (this.myData.realname != null && this.myData.tel != null) {
          this.myData.role = "申请成为维修员"
          this.updateMyInfo()
          this.$message({
            type: 'success',
            message: '已提交申请，请等待审核'
          });
        } else {
          this.$message({
            type: 'error',
            message: '请先完善真实姓名和联系方式'
          });
        }
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消'
        });
      });
    },
    updateMyInfo() {
      this.$axios.put('http://localhost:8080/user/userInfoSet', this.myData).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '成功!'
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
};
</script>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed black;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: cadetblue;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>

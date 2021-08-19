<template>
  <el-container>
    <div style="width: 100%">
      <div style="width: 64%;float: left;background-color: white;padding: 5px;">
        <div style="border-bottom: 2px solid cadetblue;">
          <label style="font: 20px Extra large">发布问题</label>
        </div>
        <div style="border-bottom:cadetblue 2px solid;margin-top: 10px;">
          <label>标题</label>
          <el-input v-model="problemData.title" placeholder="请输入标题" clearable></el-input>
          <label>详情</label>
          <el-input v-model="problemData.content" type="textarea" :rows="3" placeholder="请输入内容"></el-input>
        </div>
        <div style="margin-top: 10px">
          <div style="float: right">
            <el-button type="primary" icon="el-icon-finished" @click="createProblem()">发布</el-button>
          </div>
        </div>
      </div>
      <div style="width: 32%;height: auto;float: right;background-color: lightgray;padding: 5px">
        <div style="width: 100%;height: 250px;text-align: center;background-image:linear-gradient(to top, lightskyblue,peachpuff);">
          <Avatar  :username="realname"
                   :src="avator"
                   background-color="white"
                   color="cadetblue"
                   style="vertical-align: middle;width: 100px;height: 100px;margin-top: 10%"
                   :inline="true">
          </Avatar>
          <span><h4>{{ currentUser.userName }}</h4></span>
          <span><h5>{{ currentUser.realname }}</h5></span>
        </div>
        <UserComputer></UserComputer>
      </div>
      <div style="
          width: 65%;
          height: 1300px;
          float: left;
          overflow-x: hidden;
          overflow-y: scroll;
          margin-top: 30px;
          ">
        <Problem></Problem>
      </div>
    </div>
  </el-container>
</template>

<script>
import Problem from "@/views/userInterface/componet/Problem";
import UserComputer from "@/views/userInterface/componet/UserComputer";
import Avatar from 'vue-avatar'
export default {
  name: "HomePage",
  components: {Problem,UserComputer,Avatar},
  data() {
    return {
      realname: this.$store.getters.getUser.realname,
      avator: this.$store.getters.getUser.avator,
      currentUser: this.$store.getters.getUser,
      problemData: {
        userId: this.$store.getters.getUserId,
        title: "",
        content: "",
      },
    }
  },
  methods: {
    createProblem() {
      if(this.problemData.title!==""&&this.problemData.content!==""){
        this.$axios.post('http://localhost:8080/problem/create', this.problemData).then(resp => {
          if (resp.data.code === 200) {
            this.$notify({
              title: '成功',
              type: 'success',
              message: resp.data.data,
              duration: 2000
            });
            this.problemData.title = ""
            this.problemData.content = ""
          }
        })
      }else {
        this.$message({
          type: 'warning',
          message: "先写点东西吧"
        });
      }
    },
  },
  created() {
  }
}
</script>

<style scoped>
.el-button {
  background-color: cadetblue;
  color: white;
  opacity: 80%;
}

div::-webkit-scrollbar {
  display: none;
}

</style>

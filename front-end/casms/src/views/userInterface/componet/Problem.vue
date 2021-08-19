<template>
  <div class="infinite-list-wrapper" style="overflow:auto">
    <ul v-infinite-scroll="load"
        infinite-scroll-disabled="disabled"
        class="list">
      <li v-for="(problem,index) in problemData" :key="index" class="list-item">
        <div style="border:grey 1px hidden;
              padding: 5px;
              margin-top: 20px;
              background-color: white">
          <div style="height: 42px;border-bottom: 2px solid darkgrey;">
            <div style="float: left">
              <Avatar  :username="problem.userName"
                       :src="avator"
                       background-color="white"
                       color="cadetblue"
                       style="width: 40px;height: 40px"
                       :inline="true">
              </Avatar>
            </div>
            <div style="float:left;margin-left: 20px;line-height: 42px"><span>{{ problem.userName }}</span></div>
            <div style="float: right;margin-top: 10px">
              <label style="color: #67C23A">{{ problem.model }}</label>||
              <el-tag style="color: #409EFF">{{ problem.state }}</el-tag>
              ||
              <label style="color: #909399">{{ problem.createTime }}</label>
            </div>
          </div>
          <div style="height:auto;margin-right: 70px">
            <div style="width: 100%;text-align: left;padding: 10px 0 0 20px;">
              <h3>{{ problem.title }}</h3>
            </div>
            <br>
            <div style="width: 100%;text-align: left;padding: 0px 40px 40px 40px;">
              <label style="margin-right: 100px;">{{ problem.content }}</label>
            </div>

          </div>

          <div style="height: 50px;border-bottom: 1px solid darkgrey;border-top: 1px solid darkgrey;padding-top: 5px">
            <el-row :gutter="24">
              <el-col :span="6">
                <div>
                  <el-button icon="el-icon-view" circle></el-button>
                </div>
              </el-col>
              <el-col :span="6">
                <div>
                  <el-button icon="el-icon-star-off" circle></el-button>
                </div>
              </el-col>
              <el-col :span="6">
                <div>
                  <el-button icon="el-icon-chat-dot-square" @click="toggleShopShow(problem.problemId,index)"
                             circle></el-button>
                </div>
              </el-col>
              <el-col :span="6">
                <div>
                  <el-button icon="el-icon-more" circle></el-button>
                </div>
              </el-col>
            </el-row>
          </div>

          <el-collapse-transition>
            <div v-show="replyShow[index]" @change="changeData">
              <div style="margin: 10px 10px">
                <el-input placeholder="请输入回复内容" v-model="reply.replyContent">
                  <template #append>
                    <el-button type="primary" @click="replyThisProblem">回复</el-button>
                  </template>
                </el-input>
              </div>
              <div>
                <ul v-for="(i,index) in replyData" :key="index"><!--将v-for循环放入这个div中就可以响应手风琴效果了-->
                  <li style="display: inline-block; width: 95%;border-bottom: lightslategray 1px solid;margin-top: 3px;">
                    <Avatar  :username="i.userName"
                             :src="avator"
                             background-color="white"
                             color="cadetblue"
                             style="width: 40px;height: 40px;float: left"
                             :inline="true">
                    </Avatar>
                    <span style="float: left;margin-top: 10px;color: cadetblue">{{ i.userName }}<el-tag
                        style="margin-left: 5px">{{ i.role }}</el-tag></span>
                    <span
                        style="float: left;margin-top: 10px;margin-left: 20px;line-height: 30px;text-align: left;text-indent:2em">{{
                        i.replyContent
                      }}</span>
                  </li>
                </ul>
              </div>
            </div>
          </el-collapse-transition>
        </div>
      </li>
    </ul>
    <p v-if="loading">加载中...</p>
    <p v-if="noMore">没有更多了</p>
  </div>
</template>

<script>
import Avatar from 'vue-avatar'

export default {
  components:{Avatar},
  name: "problem",
  data() {
    return {
      replyShow: [false], //默认内容不显示
      loading: false,
      problemTotal: "",
      problemData: [],
      replyData: [],
      reply: {
        userId: this.$store.getters.getUserId,
        replyContent: '',
        problemId: '',
      },
      val: ''
    }
  },
  created: function () {
    this.getProblems();
  },
  computed: {
    noMore() {
      return this.problemTotal >= this.problemTotal
    },
    disabled() {
      return this.loading || this.noMore
    }
  },
  methods: {
    getProblems() {
      this.$axios.post('http://localhost:8080/problem/getProblems').then(resp => {
        console.log(resp.data.data)
        this.problemData = resp.data.data
        this.problemTotal = this.problemData.length
      })
    },
    toggleShopShow(problemId, index) {
      this.reply.problemId = problemId;
      if (index === this.i || this.i === -1) {
        this.$set(this.replyShow, index, !this.replyShow[index])
        this.i = index
      } else {
        this.$set(this.replyShow, this.i, false)
        this.$set(this.replyShow, index, !this.replyShow[index])
        this.i = index;
      }
      this.$axios.post('http://localhost:8080/reply/getReplysByProblemId/' + problemId).then(resp => {
        this.replyData = resp.data.data;
      })
    },
    changeData() {

    },
    replyThisProblem() {
      if (this.reply.replyContent !== "") {
        this.$axios.post('http://localhost:8080/reply/create', this.reply).then(
            this.$message.success('回复成功'),
            this.$router.go(0)
        )
      } else {
        this.$message({
          type: 'warning',
          message: "先写点东西吧"
        });
      }
    },
    load() {
      this.loading = true
      setTimeout(() => {
        this.count += 2
        this.loading = false
      }, 2000)
    },
  }
}
</script>

<style scoped>
.show {
  display: block;
}

.hide {
  display: none;
}

.el-button {
  background-color: cadetblue;
  color: white;
  opacity: 80%;
}

ul {
  padding: 0;
}

li {
  list-style-type: none;
  text-align: center;
  padding: 0;
}
</style>

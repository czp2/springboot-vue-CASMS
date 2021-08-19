<template>
  <el-container>
    <el-header style="background-color: whitesmoke">

    </el-header>
    <el-table
        :data="problemData.filter(data => !search || data.title.toLowerCase().includes(search.toLowerCase()) || data.userName.toLowerCase().includes(search.toLowerCase()))"
        height="100%"
        :default-sort="{prop: 'createTime', order: 'descending'}"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'>
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="标题">
              <span>{{ props.row.title }}</span>
            </el-form-item>
            <el-form-item label="问题内容">
              <span>{{ props.row.content }}</span>
            </el-form-item>
            <el-form-item label="问题解决者">
              <span>{{ props.row.solver }}</span>
            </el-form-item>
            <el-form-item label="解决时间">
              <span>{{ props.row.solutionTime }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column prop="problemId" label="问题id" min-width="10%" sortable>
      </el-table-column>
      <el-table-column prop="userName" label="用户" min-width="10%">
      </el-table-column>
      <el-table-column prop="title" label="标题" min-width="30%">
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" min-width="20%" sortable>
      </el-table-column>
      <el-table-column prop="state" label="状态"
                       min-width="10%"
                       :filters="[{ text: '处理中', value: '处理中' }, { text: '已解决', value: '已解决' }]"
                       :filter-method="filterTag"
                       filter-placement="bottom-end">
      </el-table-column>
      <el-table-column align="right" label="操作" min-width="20%" fixed="right">
        <template slot="header" slot-scope="scope">
          <el-input v-model="search" size="mini" placeholder="请输入标题关键字">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </template>
        <template slot-scope="scope">
          <el-tooltip content="查看评论" placement="top">
            <el-button type="info" icon="el-icon-chat-line-square" @click="getReplyByProblemId(scope.row)"
                       plain></el-button>
          </el-tooltip>
          <el-tooltip content="删除问题" placement="top">
            <el-button type="danger" icon="el-icon-delete-solid" @click="deleteProblem(scope.row.problemId)"
                       plain></el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog title="问题回复（绿底的为用户选择的最佳回答）" :visible.sync="dialogFormVisible" width="80%">
      <el-table :data="replyData"
                :default-sort="{prop: 'createTime', order: 'descending'}"
                :header-cell-style='cellStyle'
                :cell-style='cellStyle'
                :row-class-name="tableRowClassName">
        <el-table-column prop="userName" label="昵称" min-width="20%" sortable>
        </el-table-column>
        <el-table-column prop="role" label="角色" min-width="10%"
                         :filters="[{ text: '管理员', value: '管理员' }, { text: '普通用户', value: '普通用户' }, { text: '维修人员', value: '维修人员' }]"
                         :filter-method="filterTag1"
                         filter-placement="bottom-end">
        </el-table-column>
        <el-table-column prop="replyContent" label="内容" min-width="30%">
        </el-table-column>
        <el-table-column prop="createTime" label="回复时间" min-width="20%" sortable>
        </el-table-column>
        <el-table-column label="操作" min-width="20%">
          <template slot-scope="scope">
            <el-tooltip content="删除这条回复" placement="top">
              <el-button type="danger" icon="el-icon-delete" @click="deleteReply(scope.row.replyId)"
                         plain></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="closeThisDialog">确定</el-button>
        <el-button @click="closeThisDialog">返回</el-button>
      </div>
    </el-dialog>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      search: '',
      problemData: [],
      replyData: [],
      problem: {},
      dialogFormVisible: false,
      cellStyle:{
        'text-align':'center'
      }
    }
  },
  created: function () {
    this.getProblems()
  },
  methods: {
    filterTag(value, row) {
      return row.state === value;
    },
    filterTag1(value, row) {
      return row.role === value;
    },
    tableRowClassName({row, rowIndex}) {
      if (this.problem.solutionId === row.replyId) {
        return "success-row"
      } else {
        return ""
      }
    },
    getProblems() {
      this.$axios.post('http://localhost:8080/problem/getProblems').then(resp => {
        this.problemData = resp.data.data
      })
    },
    getReplyByProblemId(problem) {
      this.problem = problem
      console.log(this.problem)
      this.dialogFormVisible = true
      this.$axios.post('http://localhost:8080/reply/getReplysByProblemId/' + problem.problemId).then(resp => {
        this.replyData = resp.data.data;
      })
    },
    closeThisDialog() {
      this.dialogFormVisible = false;
      this.getProblems()
    },
    deleteProblem(id) {
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/problem/delete/' + id).then(resp => {
          if (resp.data.code == 200) {
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
            this.$router.go(0)
          }
        })

      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    deleteReply(id) {
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        if (this.problem.solutionId === id) {
          this.problem.solutionId = ""
          this.problem.state = "处理中"
          this.problem.solutionTime = ""
          this.$axios.put('http://localhost:8080/problem/update', this.problem).then(resp => {
            if (resp.data.code == 200) {
              this.$message({
                type: 'success',
                message: '成功解除最佳答案绑定!'
              })
            }
          })
        }
        this.$axios.delete('http://localhost:8080/reply/delete/' + id).then(resp => {
          if (resp.data.code == 200) {
            this.$message({
              type: 'success',
              message: '成功删除!'
            })
            this.getReplyByProblemId(this.problem)
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    }
  }
}
</script>

<style>
.demo-table-expand {
  font-size: 0;
}

.demo-table-expand label {
  width: 80%;
  color: #99a9bf;
}

.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 80%;
}
</style>


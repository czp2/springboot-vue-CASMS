<template>
  <el-container>
    <el-header style="background-color:cadetblue;height: 60px;opacity: 70%">

    </el-header>
    <el-main style="background-color: whitesmoke;height: 80vh">
      <div style="width: 100%;height: 100%">
        <el-table
            :data="problemData.filter(data => !search || data.title.toLowerCase().includes(search.toLowerCase()))"
            height="100%"
            :header-cell-style='cellStyle'
            :cell-style='cellStyle'
            :default-sort="{prop: 'createTime', order: 'descending'}"
            stripe>
          <el-table-column type="expand">
            <template slot-scope="props">
              <el-form label-position="left" inline class="demo-table-expand">
                <el-form-item label="标题">
                  <span>{{ props.row.title }}</span>
                </el-form-item>
                <el-form-item label="问题内容">
                  <span>{{ props.row.content }}</span>
                </el-form-item>
                <el-form-item label="解决时间">
                  <span>{{ props.row.solutionTime }}</span>
                </el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column prop="title" label="标题" min-width="20%">
          </el-table-column>
          <el-table-column prop="state"
                           label="状态"
                           min-width="10%"
                           :filters="[{ text: '处理中', value: '处理中' }, { text: '已解决', value: '已解决' }]"
                           :filter-method="filterTag"
                           filter-placement="bottom-end">
          </el-table-column>
          <el-table-column prop="createTime" label="提问日期" min-width="15%" sortable>
          </el-table-column>
          <el-table-column prop="operation" label="操作" min-width="20%">
            <template slot="header" slot-scope="scope">
              <el-input v-model="search" size="mini" placeholder="请输入标题关键字">
                <el-button slot="append" icon="el-icon-search"></el-button>
              </el-input>
            </template>
            <template slot-scope="scope">
              <el-tooltip content="详情" placement="top">
                <el-button type="primary" icon="el-icon-info" @click="getReplyByProblemId(scope.row)"
                           plain></el-button>
              </el-tooltip>
              <el-tooltip content="删除此问题" placement="top">
                <el-button type="danger" icon="el-icon-delete-solid" @click="deleteProblem(scope.row.problemId)"
                           plain></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>

    <el-dialog title="问题回复" :visible.sync="dialogFormVisible" width="60%">
      <el-table :data="replyData"
                :default-sort="{prop: 'createTime', order: 'descending'}"
                :header-cell-style='cellStyle'
                :cell-style='cellStyle'
                :row-class-name="tableRowClassName">
        <el-table-column prop="userName" label="昵称" min-width="10%">
        </el-table-column>
        <el-table-column prop="role" label="角色" min-width="15%"
                         :filters="[{ text: '管理员', value: '管理员' }, { text: '普通用户', value: '普通用户' }, { text: '维修人员', value: '维修人员' }]"
                         :filter-method="filterTag1"
                         filter-placement="bottom-end">
        </el-table-column>
        <el-table-column prop="replyContent" label="内容" min-width="30%">
        </el-table-column>
        <el-table-column prop="createTime" label="回复时间" min-width="25%" sortable>
        </el-table-column>
        <el-table-column label="操作" min-width="20%">
          <template slot-scope="scope">
            <el-tooltip content="设为最佳回答" placement="top">
              <el-button type="success" icon="el-icon-s-claim" @click="setSelected(scope.row.replyId)"
                         plain></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false;">确定</el-button>
        <el-button @click="dialogFormVisible=false">返回</el-button>
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
      dialogFormVisible: false,
      problem: {},
      cellStyle:{
        'text-align':'center'
      }
    }
  },
  methods: {
    filterTag(value, row) {
      return row.state === value;
    },
    filterTag1(value, row) {
      return row.role === value;
    },
    tableRowClassName({row, rowIndex}) {
      if(this.problem.solutionId === row.replyId){
        return "success-row"
      }else {
        return ""
      }
    },
    setSelected(replyId) {
      this.problem.solutionId = replyId
      this.problem.state = "已解决"
      this.problem.solutionTime = this.getYMDHMS(Date())
      console.log(this.problem)
      this.$axios.put('http://localhost:8080/problem/update', this.problem).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '修改成功!'
          })
        }
      })
    },
    getProblemData() {
      this.$axios.post('http://localhost:8080/problem/getMyProblems/' + this.$store.getters.getUserId).then(resp => {
        console.log(resp.data.data)
        this.problemData = resp.data.data
      })
    },
    getReplyByProblemId(problem) {
      this.problem = problem
      this.dialogFormVisible = true
      this.$axios.post('http://localhost:8080/reply/getReplysByProblemId/' + problem.problemId).then(resp => {
        this.replyData = resp.data.data;
      })
    },
    deleteProblem(id) {
      this.$confirm('此操作将删除此问题, 是否继续?', '提示', {
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
            this.$router.go(0);
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    getYMDHMS(timestamp) {
      let time = new Date(timestamp)
      let year = time.getFullYear()
      const month = (time.getMonth() + 1).toString().padStart(2, '0')
      const date = (time.getDate()).toString().padStart(2, '0')
      const hours = (time.getHours()).toString().padStart(2, '0')
      const minute = (time.getMinutes()).toString().padStart(2, '0')
      const second = (time.getSeconds()).toString().padStart(2, '0')
      return year + '-' + month + '-' + date + ' ' + hours + ':' + minute + ':' + second
    }
  },
  created() {
    this.getProblemData()
  }
}
</script>

<style>
.el-table .success-row {
  background: #f0f9eb;
}
.demo-table-expand {
  font-size: 0;
}

.demo-table-expand label {
  width: 200px;
  color: #99a9bf;
}

.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}
</style>

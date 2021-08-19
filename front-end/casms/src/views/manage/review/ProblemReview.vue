<template>
  <el-container>
    <el-table
        :data="problemData.filter(data => !search || data.title.toLowerCase().includes(search.toLowerCase()))"
        height="100%"
        :default-sort="{prop: 'createTime', order: 'descending'}"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'>
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="问题ID">
              <span>{{ props.row.problemId }}</span>
            </el-form-item>
            <el-form-item label="用户ID">
              <span>{{ props.row.userId }}</span>
            </el-form-item>
            <el-form-item label="标题">
              <span>{{ props.row.title }}</span>
            </el-form-item>
            <el-form-item label="问题内容">
              <span>{{ props.row.content }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column prop="title" label="标题" min-width="10%">
      </el-table-column>
      <el-table-column prop="content" label="问题内容" min-width="40%">
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" min-width="20%" sortable>
      </el-table-column>
      <el-table-column align="right" label="操作" min-width="30%" fixed="right">
        <template slot="header" slot-scope="scope">
          <el-input v-model="search" size="mini" placeholder="请输入标题关键字">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </template>
        <template slot-scope="scope">
          <el-tooltip content="通过审核" placement="top">
            <el-button type="success" icon="el-icon-check" @click="setApproved(scope.row)"
                       plain>通过</el-button>
          </el-tooltip>
          <el-tooltip content="不通过并删除" placement="top">
            <el-button type="danger" icon="el-icon-close" @click="deleteProblem(scope.row.problemId)"
                       plain>删除</el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      search: '',
      problemData: [],
      cellStyle:{
        'text-align':'center'
      }
    }
  },
  created: function () {
    this.getProblems()
  },
  methods: {
    getProblems() {
      this.$axios.post('http://localhost:8080/problem/reviewProblems').then(resp => {
        this.problemData = resp.data.data
      })
    },
    setApproved(row){
        this.$confirm('确定通过吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          row.state = "处理中"
          this.$axios.put('http://localhost:8080/problem/update',row).then(resp => {
            if (resp.data.code == 200) {
              this.$message({
                type: 'success',
                message: '成功!'
              })
              this.$router.go(0)
            }
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消'
          });
        });
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
  }
}
</script>

<style>
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


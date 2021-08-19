<template>
  <el-container>
    <el-table
        :data="userData.filter(data => !search || data.userName.toLowerCase().includes(search.toLowerCase()))"
        height="100%"
        :default-sort="{prop: 'createTime', order: 'descending'}"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'>
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="用户ID">
              <span>{{ props.row.userId }}</span>
            </el-form-item>
            <el-form-item label="用户昵称">
              <span>{{ props.row.userName }}</span>
            </el-form-item>
            <el-form-item label="真实姓名">
              <span>{{ props.row.realname }}</span>
            </el-form-item>
            <el-form-item label="联系地址">
              <span>{{ props.row.address }}</span>
            </el-form-item>
            <el-form-item label="联系电话">
              <span>{{ props.row.tel }}</span>
            </el-form-item>
            <el-form-item label="创建时间">
              <span>{{ props.row.createTime }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column prop="userId" label="用户ID" min-width="10%">
      </el-table-column>
      <el-table-column prop="userName" label="用户昵称" min-width="40%">
      </el-table-column>
      <el-table-column prop="realname" label="真实姓名" min-width="20%" sortable>
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
          <el-tooltip content="不通过" placement="top">
            <el-button type="danger" icon="el-icon-s-release" @click="notApproved(scope.row)"
                       plain>不通过</el-button>
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
      userData: [],
      cellStyle:{
        'text-align':'center'
      },
      flag: "1"
    }
  },
  created: function () {
    this.getUsers()
  },
  methods: {
    getUsers(){
      this.$axios.post('http://localhost:8080/user/getUsers?query='+this.flag).then(resp => {
        this.userData = resp.data.data
      })
    },
    setApproved(row){
      this.$confirm('是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        row.role = "维修人员"
        this.updateUser(row)
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    notApproved(row){
      this.$confirm('是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        row.role = "普通用户"
        this.updateUser(row)
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    updateUser(row) {
      this.$axios.put('http://localhost:8080/user/userInfoSet', row).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '修改成功!'
          });
          this.getUsers()
        }
      })
    },
  }
}
</script>

<style>
</style>


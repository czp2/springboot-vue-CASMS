<template>
  <el-container>
    <el-header style="background-color: whitesmoke">
      <div style="float: right">
        <el-input v-model="search" placeholder="请输入内容">
          <el-button slot="append" icon="el-icon-search" @click="selectUser"></el-button>
        </el-input>
      </div>
    </el-header>
    <el-table
        :data="userData"
        height="550"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'
    >
      <el-table-column prop="userId" label="用户id" min-width="10%" sortable>
      </el-table-column>
      <el-table-column prop="userName" label="昵称" min-width="10%" sortable>
      </el-table-column>
      <el-table-column prop="realname" label="真名" min-width="10%" sortable>
      </el-table-column>
      <el-table-column prop="tel" label="电话" min-width="10%">
      </el-table-column>
      <el-table-column prop="role" label="角色" min-width="10%"
                       :filters="[{ text: '管理员', value: '管理员' },
                       { text: '普通用户', value: '普通用户' },
                       { text: '维修人员', value: '维修人员' },]"
                       :filter-method="filterTag"
                       filter-placement="bottom-end">
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" min-width="10%" sortable>
      </el-table-column>
      <el-table-column align="right" label="操作" min-width="10%" fixed="right">
        <template slot-scope="scope">
          <el-button-group>
            <el-button type="info" icon="el-icon-info" @click="updateDialog(scope.row)" plain></el-button>
            <el-button type="danger" icon="el-icon-delete-solid" @click="deleteUser(scope.row.userId)"
                       plain></el-button>
          </el-button-group>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog title="修改用户信息" :visible.sync="dialogFormVisible">
      <el-form :model="user" style="text-align: center">
        <el-form-item label="昵称" :label-width="formLabelWidth">
          <el-input v-model="user.userName" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="真名" :label-width="formLabelWidth">
          <el-input v-model="user.realname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址" :label-width="formLabelWidth">
          <el-input v-model="user.address" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话" :label-width="formLabelWidth">
          <el-input v-model="user.tel" autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="邮箱" :label-width="formLabelWidth">
          <el-input v-model="user.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色" :label-width="formLabelWidth">
          <el-select v-model="user.role" placeholder="请选择">
            <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">返 回</el-button>
        <el-button type="primary" @click="updateUser()">确 定</el-button>
      </div>
    </el-dialog>
  </el-container>

</template>

<script>
export default {
  data() {
    return {
      search: '',
      userData: [],
      user: {},
      dialogFormVisible: false,
      formLabelWidth: '60px',
      options: [{
        value: '普通用户',
        label: '普通用户'
      }, {
        value: '维修人员',
        label: '维修人员'
      }, {
        value: '管理员',
        label: '管理员'
      },],
      cellStyle:{
        'text-align':'center'
      }
    }
  },
  created: function () {
    this.getUsers()
  },
  methods: {
    filterTag(value, row) {
      return row.role === value;
    },
    getUsers(){
      this.$axios.post('http://localhost:8080/user/getUsers?query='+"0").then(resp => {
        this.userData = resp.data.data
      })
    },
    updateDialog(row) {
      this.dialogFormVisible = true
      this.user = Object.assign(row);//将数据传入dialog页面
    },
    updateUser() {
      this.$axios.put('http://localhost:8080/user/userInfoSet', this.user).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '修改成功!'
          });
          this.dialogFormVisible = false
        }
      })
    },
    selectUser() {
      this.$axios.post('http://localhost:8080/user/selectUser?element='+this.search).then(resp => {
        if (resp.data.code == 200) {
          this.userData = resp.data.data
          console.log(this.userData)
        }
      })
    },
    deleteUser(id) {
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/user/deleteUserById/' + id).then(resp => {
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
    }
  }
}
</script>


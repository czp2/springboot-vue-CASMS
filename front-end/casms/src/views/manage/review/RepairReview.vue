<template>
  <el-container>
    <el-table
        :data="repairData.filter(data => !search || data.repairContent.toLowerCase().includes(search.toLowerCase()))"
        height="100%"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'
        :default-sort="{prop: 'createTime', order: 'descending'}"
        stripe>
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="维修订单号">
              <span>{{ props.row.repairId }}</span>
            </el-form-item>
            <el-form-item label="用户ID">
              <span>{{ props.row.userId }}</span>
            </el-form-item>
            <el-form-item label="维修内容">
              <span>{{ props.row.repairContent }}</span>
            </el-form-item>
            <el-form-item label="下单时间">
              <span>{{ props.row.createTime }}</span>
            </el-form-item>
            <el-form-item label="约定维修时间">
              <span>{{ props.row.appointmentTime }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column prop="repairContent" label="维修内容" min-width="25%">
      </el-table-column>
      <el-table-column prop="createTime" label="下单时间" min-width="15%" sortable>
      </el-table-column>
      <el-table-column prop="appointmentTime" label="预约时间" min-width="15%" sortable>
      </el-table-column>
      <el-table-column min-width="30%">
        <template slot="header" slot-scope="scope">
          <el-input v-model="search" size="mini" placeholder="请输入维修内容关键字">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </template>
        <template slot-scope="scope">
          <el-tooltip content="通过审核" placement="top">
            <el-button type="success" icon="el-icon-check" @click="setApproved(scope.row)"
                       plain>通过</el-button>
          </el-tooltip>
          <el-tooltip content="不通过并删除" placement="top">
            <el-button type="danger" icon="el-icon-close" @click="deleteRepair(scope.row.repairId)"
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
      repairData: [],
      repair: {},
      search: '',
      queryWrapper: {
        state: "待审核"
      },
      userData: {},
      cellStyle: {
        'text-align': 'center'
      }
    }
  },
  methods: {
    getRepairData() {
      this.$axios.post('http://localhost:8080/repair/getRepairList', this.queryWrapper).then(resp => {
        this.repairData = resp.data.data
      })
    },
    setApproved(repair) {
      this.$confirm('确定接单吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        repair.state = "已审核"
        this.$axios.put('http://localhost:8080/repair/update', repair).then(resp => {
          if (resp.data.code == 200) {
            this.$message({
              type: 'success',
              message: '成功!'
            })
            this.getRepairData()
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消'
        });
      });
    },
    deleteRepair(id) {
      this.$confirm('确定删除?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/repair/delete/' + id)
        this.$message({
          type: 'success',
          message: '删除成功!'
        });
        this.$router.go(0)
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
  },
  created() {
    this.getRepairData()
  }
}
</script>

<style>

</style>

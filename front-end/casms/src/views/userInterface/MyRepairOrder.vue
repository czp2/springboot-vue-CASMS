<template>
  <el-container>
    <el-header style="background-color:cadetblue;height: 60px;opacity: 70%">
    </el-header>
    <el-main style="background-color: whitesmoke;height: 80vh">
      <div style="width: 100%;height: 100%">
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
                <el-form-item label="维修员编号">
                  <span>{{ props.row.repairman }}</span>
                </el-form-item>
                <el-form-item label="维修员昵称">
                  <span>{{ props.row.repairmanName }}</span>
                </el-form-item>
                <el-form-item label="维修员真实姓名">
                  <span>{{ props.row.repairmanName }}</span>
                </el-form-item>
                <el-form-item label="维修员联系电话">
                  <span>{{ props.row.tel}}</span>
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
                <el-form-item label="完成维修时间">
                  <span>{{ props.row.completionTime }}</span>
                </el-form-item>
                <el-form-item label="维修价格">
                  <span>{{ props.row.price }}</span>
                </el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column prop="repairContent" label="维修内容" min-width="20%">
          </el-table-column>
          <el-table-column prop="appointmentTime" label="预约时间" min-width="15%" sortable>
          </el-table-column>
          <el-table-column prop="state" label="状态"
                           min-width="20%"
                           :filters="[{ text: '待审核', value: '待审核' },
                           { text: '已审核', value: '已审核' },
                           { text: '已接单', value: '已接单' },
                           { text: '已处理', value: '已处理' },
                           { text: '已完成', value: '已完成' }]"
                           :filter-method="filterTag"
                           filter-placement="bottom-end">

          </el-table-column>
          <el-table-column min-width="25%">
            <template slot="header" slot-scope="scope">
              <el-input v-model="search" size="mini" placeholder="请输入维修内容关键字">
                <el-button slot="append" icon="el-icon-search"></el-button>
              </el-input>
            </template>
            <template slot-scope="scope">
              <el-tooltip content="结束流程" placement="top">
                <el-button type="success" icon="el-icon-s-claim" @click="setCompletion(scope.row)" plain></el-button>
              </el-tooltip>
              <el-tooltip :content="scope.row.tel" placement="top">
                <el-button type="primary" icon="el-icon-phone" plain></el-button>
              </el-tooltip>
              <el-tooltip content="删除订单" placement="top">
                <el-button type="danger" icon="el-icon-delete" @click="deleteRepair(scope.row)"
                           plain></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      repairData: [],
      repair: {},
      search: '',
      cellStyle:{
        'text-align':'center'
      }
    }
  },
  methods: {
    filterTag(value, row) {
      return row.state === value;
    },
    getRepairData() {
      console.log(this.$store.getters.getUserId)
      this.$axios.post('http://localhost:8080/repair/getMyRepair/' + this.$store.getters.getUserId).then(resp => {
        this.repairData = resp.data.data
      })
    },
    setCompletion(repair) {
      this.$confirm('是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        if (repair.state === "已处理") {
          this.repair = repair
          this.repair.completionTime = this.getYMDHMS(Date())
          this.repair.state = "已完成"
          this.$axios.put('http://localhost:8080/repair/update', this.repair).then(resp => {
            if (resp.data.code == 200) {
              this.$message({
                type: 'success',
                message: '成功!'
              })
              this.$router.go(0)
            }
          })
        } else {
          this.$message({
            type: 'warning',
            message: '还没有开始维修/已结束!'
          })
        }
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    deleteRepair(repair) {
      this.$confirm('是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        if(repair.state != "已完成"||repair.state != "已处理"){
          this.$axios.delete('http://localhost:8080/repair/delete/' + repair.repairId).then(resp => {
            if (resp.data.code == 200) {
              this.$message({
                type: 'success',
                message: '删除成功!'
              });
              this.$router.go(0);
            }
          })
        }else {
          this.$message({
            type: 'info',
            message: '无法删除'
          });
        }
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
    this.getRepairData()
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

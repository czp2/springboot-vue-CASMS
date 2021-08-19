<template>
  <el-container>
    <el-main
        style="
        display: flex;
        background-color: whitesmoke;">
      <div style="width: 100%;">
        <el-table
            :data="repairData.filter(data => !search || data.repairContent.toLowerCase().includes(search.toLowerCase()))"
            height="800"
            :header-cell-style='cellStyle'
            :cell-style='cellStyle'
            :default-sort="{prop: 'appointmentTime', order: 'descending'}"
            stripe>
          <el-table-column prop="repairId" label="维修ID" min-width="10%" sortable>
          </el-table-column>
          <el-table-column prop="reason" label="故障原因" min-width="10%">
          </el-table-column>
          <el-table-column prop="appointmentTime" label="预约时间" min-width="15%" sortable>
          </el-table-column>
          <el-table-column prop="price" label="基础维修费" min-width="10%">
          </el-table-column>
          <el-table-column min-width="15%">
            <template slot="header" slot-scope="scope">
              <el-input v-model="search" size="mini" placeholder="请输入维修内容关键字">
                <el-button slot="append" icon="el-icon-search"></el-button>
              </el-input>
            </template>
            <template slot-scope="scope">
              <el-tooltip content="查看用户订单关键信息" placement="top">
                <el-button type="success" icon="el-icon-zoom-in" @click="getUserInfo(scope.row)"
                           plain></el-button>
              </el-tooltip>
              <el-tooltip content="我要接单" placement="top">
                <el-button type="warning" icon="el-icon-plus" @click="setReceived(scope.row)" plain></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>

    <el-dialog
        title="订单和用户信息"
        :visible.sync="dialogVisible"
        width="30%">
      <el-card :body-style="{ padding: '10px' }" >
        <div style="text-align: center">
          <el-avatar
              shape="square"
              :size="100"
              fit="cover"
              style="margin-top: 15px;"
              src="https://iconfont.alicdn.com/t/70a42809-f6ff-4af9-a3f7-cbe076281e3b.png"
          ></el-avatar>
        </div>
        <div style="float:left;margin: 10px auto auto 20px;padding: 10px;text-align: left">
          <div><span>用户昵称</span><span style="margin-left: 20px">{{ this.userData.userName }}</span></div>
          <div style="margin-top: 20px"><span>联系方式</span><span style="margin-left: 20px">{{ this.userData.tel }}</span></div>
          <div style="margin-top: 20px"><span>联系地址</span><span style="margin-left: 20px">{{ this.userData.address }}</span></div>
          <div style="margin-top: 20px"><span>维修内容</span><span style="margin-left: 20px">{{ this.repair.repairContent }}</span></div>
          <div style="margin-top: 20px"><span>基础维修费用</span><span style="margin-left: 20px">{{ this.repair.price }}</span></div>
          <div style="margin-top: 20px"><span>预定时间</span><span style="margin-left: 20px">{{ this.repair.appointmentTime }}</span></div>
          <div style="margin-top: 20px"><span>下单时间</span><span style="margin-left: 20px">{{ this.repair.createTime}}</span></div>
        </div>
      </el-card>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      repairData: [],
      repair: {},
      search: '',
      queryWrapper:{
        state:"已审核"
      },
      dialogVisible: false,
      userData: {},
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
      this.$axios.post('http://localhost:8080/repair/getRepairList',this.queryWrapper).then(resp => {
        this.repairData = resp.data.data
      })
    },
    setReceived(repair) {
      this.$confirm('确定接单吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        repair.state = "已接单"
        repair.repairman = this.$store.getters.getUserId
        this.$axios.put('http://localhost:8080/repair/update',repair).then(resp => {
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
    getUserInfo(row) {
      this.$axios.post('http://localhost:8080/user/getUserById?id=' + row.userId).then(resp => {
        this.userData = resp.data.data
      })
      this.dialogVisible = true
      this.repair = Object.assign(row);
    },
  },
  created() {
    this.getRepairData()
  }
}
</script>

<style>

</style>

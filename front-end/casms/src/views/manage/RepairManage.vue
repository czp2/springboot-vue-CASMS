<template>
  <el-container>
    <el-header style="background-color: whitesmoke">

    </el-header>
    <el-table
        :data="repairData.filter(data => !search || data.repairContent.toLowerCase().includes(search.toLowerCase()))"
        height="100%"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'>
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="维修订单号">
              <span>{{ props.row.repairId }}</span>
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
          </el-form>
        </template>
      </el-table-column>
      <el-table-column prop="userId" label="用户ID" min-width="10%" sortable>
      </el-table-column>
      <el-table-column prop="repairContent" label="维修内容" min-width="25%">
      </el-table-column>
      <el-table-column prop="createTime" label="下单时间" min-width="15%" sortable>
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
      <el-table-column min-width="15%">
        <template slot="header" slot-scope="scope">
          <el-input v-model="search" size="mini" placeholder="请输入维修内容关键字">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </template>
        <template slot-scope="scope">
          <el-tooltip content="查看用户和维修员信息" placement="top">
            <el-button type="success" icon="el-icon-connection" @click="getInfo(scope.row)"
                       plain></el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog
        title="信息"
        :visible.sync="dialogVisible"
        width="50%">
      <div style="border: cadetblue 1px solid;border-radius: 10px">
        <el-card :body-style="{ padding: '10px'}" style="border-radius: 10px" shadow="hover">
          <div style="text-align: center">用户信息</div>
          <div style="text-align: center;float: left;margin: 20px auto auto 20px">
            <el-avatar
                shape="square"
                :size="100"
                fit="cover"
                src="https://iconfont.alicdn.com/t/70a42809-f6ff-4af9-a3f7-cbe076281e3b.png"
            ></el-avatar>
          </div>
          <div style="float:left;margin: 10px auto auto 20px;padding: 10px;text-align: left">
            <div><span>用户昵称</span><span style="margin-left: 20px">{{ this.userData.userName }}</span></div>
            <div style="margin-top: 10px"><span>真实姓名</span><span style="margin-left: 20px">{{
                this.userData.realname
              }}</span></div>
            <div style="margin-top: 10px"><span>联系方式</span><span style="margin-left: 20px">{{
                this.userData.tel
              }}</span></div>
            <div style="margin-top: 10px"><span>联系地址</span><span style="margin-left: 20px">{{
                this.userData.address
              }}</span></div>
          </div>
        </el-card>
      </div>
      <div style="border: cadetblue 1px solid;border-radius: 10px;margin-top: 30px">
        <el-card :body-style="{ padding: '10px'}" style="border-radius: 10px" shadow="hover">
          <div style="text-align: center">维修员信息</div>
          <div style="text-align: center;float: left;margin: 20px auto auto 20px">
            <el-avatar
                shape="square"
                :size="100"
                fit="cover"
                src="https://iconfont.alicdn.com/t/e8d15722-6cd6-4c1b-8701-e56662b38445.png"
            ></el-avatar>
          </div>
          <div style="float:left;margin: 10px auto auto 20px;padding: 10px;text-align: left">
            <div><span>用户昵称</span><span style="margin-left: 20px">{{ this.repairmanData.userName }}</span></div>
            <div style="margin-top: 10px"><span>真实姓名</span><span style="margin-left: 20px">{{
                this.repairmanData.realname
              }}</span></div>
            <div style="margin-top: 10px"><span>联系方式</span><span style="margin-left: 20px">{{
                this.repairmanData.tel
              }}</span></div>
            <div style="margin-top: 10px"><span>联系地址</span><span style="margin-left: 20px">{{
                this.repairmanData.address
              }}</span></div>
          </div>
        </el-card>
      </div>
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
      search: '',
      repairData: [],
      formLabelWidth: '60px',
      queryWrapper: {
        state: ""
      },
      dialogVisible: false,
      userData: {},
      repairmanData: {},
      cellStyle:{
        'text-align':'center'
      }
    }
  },
  created: function () {
    this.getRepairList()
  },
  methods: {
    filterTag(value, row) {
      return row.state === value;
    },
    getRepairList() {
      this.$axios.post('http://localhost:8080/repair/getRepairList', this.queryWrapper).then(resp => {
        this.repairData = resp.data.data
      })
    },
    updateDialog(row) {
      this.dialogFormVisible = true
      this.form = Object.assign(row);//将数据传入dialog页面
    },
    getInfo(repair) {
      this.$axios.post('http://localhost:8080/user/getUserById?id=' + repair.userId).then(resp => {
        this.userData = resp.data.data
      })
      this.$axios.post('http://localhost:8080/user/getUserById?id=' + repair.repairman).then(resp => {
        this.repairmanData = resp.data.data
      })
      this.dialogVisible = true
    }
  }
}
</script>


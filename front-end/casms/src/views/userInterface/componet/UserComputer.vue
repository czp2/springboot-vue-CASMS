<template>
  <el-container>
    <el-col>
      <el-row v-for="(computer,index) in computerData"
              :key="index">
        <el-card
            class="box-card"
            style="width: 100%;height:500px;margin-top: 10px;">
          <div slot="header" class="clearfix">
            <span>我的第{{ index + 1 }}台电脑</span>
            <el-button type="primary" style="float: right;padding: 5px" @click="toCreateRepair(computer)">申请维修
            </el-button>
          </div>
          <div style="padding: 0 0 20px 10%">
            <div style="width: 40%;float: left;text-align: left">
              <div style="width: 50%">
                <el-image
                    :src="model"
                    fit="contain "></el-image>
              </div>
              <label class="label1">电脑型号</label>
              <br>
              <label class="label2">{{ computer.model }}</label>
            </div>
            <div style="width: 40%;float: right;text-align: left">
              <div style="width: 50%">
                <el-image
                    :src="brand"
                    fit="contain "></el-image>
              </div>
              <label class="label1">品牌</label>
              <br>
              <label class="label2">{{ computer.company }}</label>
            </div>
            <div style="width: 40%;float: left;text-align: left;margin-top: 20px">
              <div style="width: 50%">
                <el-image
                    :src="cpu"
                    fit="contain "></el-image>
              </div>
              <label class="label1">中央处理器</label>
              <br>
              <label class="label2">{{ computer.cpu }}</label>
            </div>
            <div style="width: 40%;float: right;text-align: left;margin-top: 20px">
              <div style="width: 50%">
                <el-image
                    :src="graphicsCard"
                    fit="contain "></el-image>
              </div>
              <label class="label1">显卡</label>
              <br>
              <label class="label2">{{ computer.graphicsCard }}</label>
            </div>
            <div style="width: 40%;float: left;text-align: left;margin-top: 20px">
              <div style="width: 50%">
                <el-image
                    :src="memory"
                    fit="contain "></el-image>
              </div>
              <label class="label1">运行内存</label>
              <br>
              <label class="label2">{{ computer.memory }}G</label>
            </div>
            <div style="width: 40%;float: right;text-align: left;margin-top: 20px">
              <div style="width: 50%">
                <el-image
                    :src="storage"
                    fit="contain "></el-image>
              </div>
              <label class="label1">存储空间</label>
              <br>
              <label class="label2">{{ computer.storage }}</label>
            </div>
            <div style="width: 100%;float: left;text-align: left;margin-top: 30px">
              <label class="label2">保修时间截止到：{{ computer.warranty }}</label>
            </div>
          </div>
        </el-card>
      </el-row>
    </el-col>

    <el-dialog :visible.sync="dialogFormVisible" width="40%">
      <el-form ref="form" :model="repairForm" label-width="80px">
        <el-form-item label="维修电脑">
          <el-input v-model="repairForm.model" disabled></el-input>
        </el-form-item>
        <el-form-item label="故障原因">
          <el-select v-model="repairForm.reason" placeholder="请选择">
            <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="维修时间">
          <el-date-picker
              v-model="repairForm.appointmentTime"
              type="datetime"
              format
              value-format="yyyy-MM-dd HH:mm:ss"
              placeholder="选择日期时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="维修内容">
          <el-input type="textarea" :rows="2" v-model="repairForm.repairContent"></el-input>
        </el-form-item>
        <el-form-item label="付款规定">
          <el-button type="info" @click="innerVisible = true">查看维修付款相关规定</el-button>
          <el-dialog
              width="30%"
              title="维修付款相关规定"
              :visible.sync="innerVisible"
              append-to-body>
            <span>1.人为损坏的维修的价格要用户自己承担</span><br>
            <span>2.超出保修期后维修的价格要用户自己承担</span><br>
            <span>3.超出保修期后基础维修费用为20元，保修期内非人为损坏维修费用为0元</span><br>
            <span>4.最终线下付款价格以实际维修耗费零件等为准！</span><br>
            <span>5.维修申请必须通过管理员审核才能移交到维修人员处理！</span>
          </el-dialog>
        </el-form-item>
        <el-form-item size="large">
          <el-button type="primary" @click="createRepair">立即创建</el-button>
          <el-button @click="dialogFormVisible=false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      isDisabled: true,
      currentUser: this.$store.getters.getUser,
      computerData: [],
      repairForm: {
        userId: this.$store.getters.getUserId,
        model: '',
        reason: '',
        repairContent: '',
        appointmentTime: '',
        state: '待审核',
        price: ''
      },
      options: [{
        value: '人为损坏',
        label: '人为损坏'
      }, {
        value: '设备故障',
        label: '设备故障'
      }, {
        value: '未知原因',
        label: '未知原因'
      },],
      dialogFormVisible: false,
      innerVisible: false,
      model: require('/src/assets/computer/computer_model.png'),
      brand: require('/src/assets/computer/品牌.png'),
      cpu: require('/src/assets/computer/CPU.png'),
      graphicsCard: require('/src/assets/computer/显卡.png'),
      memory: require('/src/assets/computer/内存条.png'),
      storage: require('/src/assets/computer/存储空间.png'),
    }
  },
  methods: {
    createRepair() {
      if(this.repairForm.reason==="人为损坏"){
        this.repairForm.price="20"
      }
      this.$axios.post('http://localhost:8080/repair/create', this.repairForm).then(resp => {
        if (resp.data.code === 200) {
          this.$notify({
            title: '成功',
            type: 'success',
            message: resp.data.data
          });
          this.dialogFormVisible = false
        }
      })
    },
    getMyComputer() {
      this.$axios.post('http://localhost:8080/computers/getComputersByUserId/' + this.$store.getters.getUserId).then(resp => {
        if (resp.data.data != null) {
          this.computerData = resp.data.data
        }
      })
    },
    toCreateRepair(computer) {
      this.dialogFormVisible = true
      this.repairForm.model = computer.model
      if(computer.warranty<new Date()){
        this.repairForm.price="20"
      }else {
        this.repairForm.price="0"
      }
    },
  },
  created() {
    this.getMyComputer()
  }
}
</script>

<style scoped>
.label1 {
  font-size: 8px;
  color: gray;
}

.label2 {
  font-size: 10px;
  color: cadetblue;
}

</style>

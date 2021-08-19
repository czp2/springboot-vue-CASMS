<template>
  <el-container>
    <el-header style="background-color:cadetblue;height: 60px;opacity: 70%">
      <div style="float: right">
        <el-input placeholder="请输入内容">
          <el-button slot="append" icon="el-icon-search"></el-button>
        </el-input>
      </div>
    </el-header>
    <el-main
        style="
        display: flex;
        background-color: whitesmoke;
        justify-content: center;
        align-items: center;">
      <div style="width: 100%;">
        <el-table
            :data="questionnaireData"
            height="550"
            header-cell-style="text-align:center"
            cell-style="text-align:center"
            stripe>
          <el-table-column prop="questionnaireName" label="名称" min-width="30%">
          </el-table-column>
          <el-table-column prop="startTime" label="发布日期" min-width="25%">
          </el-table-column>
          <el-table-column prop="endTime" label="截止日期" min-width="25%">
          </el-table-column>
          <el-table-column prop="operation" label="操作" min-width="20%">
            <el-button-group>
              <el-button type="primary" icon="el-icon-edit" plain>填写</el-button>
              <el-button type="primary" icon="el-icon-share" plain>分享</el-button>
            </el-button-group>
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
      questionnaireData: [],
    }
  },
  methods: {
    getRepairData() {
      this.$axios.post('http://localhost:8080/questionnaire/getQuestionnaireByRole?role='+this.$store.getters.getUser.role).then(resp => {
        this.questionnaireData = resp.data.data
      })
    }
  },
  created() {
    this.getRepairData()
  }
}
</script>

<style scoped>

</style>

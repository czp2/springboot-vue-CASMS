<template>
  <el-container style="height:100%">
    <el-header>
      <div style="float: right">
        <el-input v-model="search" placeholder="请输入问卷名或者发布人">
          <el-button slot="append" icon="el-icon-search" @click="selectQuestionnaire"></el-button>
        </el-input>
      </div>
    </el-header>
    <el-table
        :data="questionnaireData"
        header-cell-style="text-align:center"
        cell-style="text-align:center"
        border
    >
      <el-table-column prop="questionnaireId" label="问卷id" width="100" fixed>
      </el-table-column>
      <el-table-column prop="questionnaireName" label="名称" width="250">
      </el-table-column>
      <el-table-column prop="startTime" label="发布日期" width="200">
      </el-table-column>
      <el-table-column prop="endTime" label="截止日期" width="200">
      </el-table-column>
      <el-table-column prop="targetPopulation" label="目标用户" width="150">
      </el-table-column>
      <el-table-column prop="publisher" label="发布人" width="100">
      </el-table-column>
      <el-table-column align="right" label="操作" min-width="150" fixed="right">
        <template slot-scope="scope">
          <el-button-group>
            <el-button type="info" icon="el-icon-info" @click="updateDialog(scope.row)" plain></el-button>
            <el-button type="danger" icon="el-icon-delete-solid" @click="deleteQuestionnaire(scope.row.questionnaireId)" plain></el-button>
          </el-button-group>
        </template>
      </el-table-column>
    </el-table>
  </el-container>
</template>

<script>
export default {
  name: "ListModel",
  data() {
    return {
      search: '',
      searchData: '',
      questionnaireData: [],
      formLabelWidth: '60px',
    }
  },
  created() {
    this.getQuestionnaireData()
  },
  methods:{
    getQuestionnaireData(){
      this.$axios.post('http://localhost:8080/questionnaire/getQuestionnaires').then(resp => {
        this.questionnaireData = resp.data.data
      })
    },
    selectQuestionnaire() {
      this.$axios.post('http://localhost:8080/questionnaire/selectQuestionnaire?element='+this.search).then(resp => {
        if (resp.data.code == 200) {
          this.questionnaireData = resp.data.data
        }
      })
    },
    deleteQuestionnaire(id) {
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/questionnaire/delete/' + id).then(resp => {
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
  }
}
</script>

<style scoped>

</style>

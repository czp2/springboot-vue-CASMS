<template>
  <el-container style="height:100%;background-color: whitesmoke">
    <el-header style="background-color: navajowhite">
      <div style="float: right" class="hidden-xs-only">
        <TypeChooseBox @changeShow="changeShow"
        ></TypeChooseBox>
      </div>
    </el-header>
    <div class="questionnaire-card-ground">
      <el-row :gutter="10">
        <el-col :xs="12" :sm="6" :md="6" :lg="3" :xl="2"
                v-for="item in questionnaireData" :key="item.questionnaireId">
          <QuestionnaireCard class="questionnaire-card" :title="item.questionnaireName" @deleteQuestionnaire="getQuestionnaireData"
                             :status="item.status" :create-time="item.createTime" :end-time="item.endTime"
                             :id="item.questionnaireId"
                             :description="item.description" :fill-count="item.fillCount"
                             v-if="checkedList.indexOf(item.status)!==-1"
          >
          </QuestionnaireCard>
        </el-col>
      </el-row>
    </div>
  </el-container>
</template>

<script>
import QuestionnaireCard from "./QuestionnaireCard";
import TypeChooseBox from "./TypeChooseBox";

export default {
  name: "Collection",
  components: {QuestionnaireCard, TypeChooseBox},
  data: function () {
    return {
      questionnaireData: [],
      checkedList: ['collecting', 'editing', 'closed'],
    }
  },
  methods: {
    getQuestionnaireData(){
      this.$axios.post('http://localhost:8080/questionnaire/getQuestionnaires').then(resp => {
        this.questionnaireData = resp.data.data
      })
    },
    changeShow(data) {
      this.checkedList = data;
    }
  },
  mounted() {
    this.getQuestionnaireData();
  },

}
</script>

<style scoped>

</style>

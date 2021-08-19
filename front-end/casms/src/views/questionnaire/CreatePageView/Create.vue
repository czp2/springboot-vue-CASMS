<template>
  <el-container style="height: 100%;background-color:white">
    <div class="create-page">
      <div :sm="8" :md="6" :lg="4" :xl="4" class="create-page-select-bar-wrapper hidden-xs-only">
        <div class="placeholder"></div>
        <SelectBar class="create-page-select-bar"
                   @addNewQuestion="addNewQuestion"
        ></SelectBar>
      </div>

      <div :sm="16" :md="16" :lg="20" :xl="20" class="create-page-question-list">
        <MainQuestionList ref="mainQuestionList"></MainQuestionList>
      </div>
    </div>
  </el-container>
</template>

<script>
import SelectBar from "./SelectBar";
import MainQuestionList from "./MainQuestionList";
import 'element-ui/lib/theme-chalk/display.css';

export default {
  name: "Create",
  components: {MainQuestionList, SelectBar},
  methods: {
    addNewQuestion(type) {
      this.$refs.mainQuestionList.addNewQuestion(type);
    }
  },
}
</script>

<style scoped>
.create-page {
  width: 100%;
  height: 100%;
  padding: 2px;
}

.create-page-question-list {
  margin-left: 20px;
  float: left;
  width: 76%;
  height: auto;
}

.create-page-select-bar {
  float: left;
  background-color: whitesmoke;
}

.placeholder {
  min-width: 250px;
  min-height: 1px;
}

</style>

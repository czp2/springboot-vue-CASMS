<template>
  <div class="select-menu">
    <el-row>
      <el-col class="select-item" @click.native="addNewQuestion('single_check')">
        <i class="el-icon-circle-check"></i>
        <p>单选</p>
      </el-col>
      <el-col class="select-item" @click.native="addNewQuestion('multi_check')">
        <i class="el-icon-edit-outline"></i>
        <p>多选</p>
      </el-col>
      <el-col class="select-item" @click.native="addNewQuestion('single_line_text')">
        <i class="el-icon-document-remove"></i>
        <p>单行文本</p>
      </el-col>
      <el-col class="select-item" @click.native="addNewQuestion('grade')">
        <i class="el-icon-star-off"></i>
        <p>评分</p>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "SelectBar",
  methods: {
    addNewQuestion(type) {
      this.$emit('addNewQuestion', type);
    }
  }
}
</script>

<style scoped>
.select-menu {
  width: 200px;
  background-color: white;
  padding: 5px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.select-item {
  width: 100px;
  padding-top: 15px;
  border-width: 1px;
  border-style: solid;
  border-color: rgba(0, 0, 0, 0.05);
  transition: all ease 300ms;
  cursor: pointer;
}

.select-item:hover {
  width: 100px;
  box-shadow: 0 2px 10px 2px rgba(0, 0, 0, 0.1);
}

</style>

<template>
  <el-container>
    <el-header style="background-color: lightcyan">
      <div style="float: left">
        <el-button type="primary"
                   icon="el-icon-top-left"
                   @click="back()">返回
        </el-button>
        <el-button type="primary"
                   icon="el-icon-circle-plus-outline"
                   @click="toCreatePage()">发布问卷
        </el-button>
        <el-button type="primary"
                   icon="el-icon-menu"
                   @click="toCardModel()">卡片模式
        </el-button>
        <el-button type="primary"
                   icon="el-icon-s-order"
                   @click="toListModel()">列表模式
        </el-button>
      </div>
    </el-header>
    <el-main style="padding: 0">
      <router-view></router-view>
    </el-main>
  </el-container>

</template>

<script>
export default {
  data() {
    return {

    }
  },
  created: function () {
  },
  methods: {
    back(){
      this.$router.push("/manage/user")
    },
    toCreatePage() {
      this.$router.push("/create")
    },
    toCardModel() {
      this.$router.push("/cardModel")
    },
    toListModel(){
      this.$router.push("/listModel")
    },
  }
}
</script>

<style scoped>
  button{
    background-color: cadetblue;
  }
</style>

<template>
  <el-container>
    <el-header style="background-color: whitesmoke">

    </el-header>
    <el-table
        :data="feedbackData.filter(data => !search || data.content.toLowerCase().includes(search.toLowerCase()))"
        height="100%"
        :default-sort="{prop: 'createTime', order: 'descending'}"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'>
      <el-table-column type="expand" :filters="[{ text: '未回复', value: true },{ text: '已回复', value: false }]"
                       :filter-method="filterTag1"
                       filter-placement="right">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="反馈ID">
              <span>{{ props.row.feedbackId }}</span>
            </el-form-item>
            <el-form-item label="创建时间">
              <span>{{ props.row.createTime }}</span>
            </el-form-item>
            <el-form-item label="回复的管理员ID">
              <span>{{ props.row.adminId }}</span>
            </el-form-item>
            <el-form-item label="回复内容">
              <span>{{ props.row.adminReply }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column prop="type" label="类型" width="200"
                       :filters="[{ text: '系统方面', value: '系统方面' },
                       { text: '服务方面', value: '服务方面' },
                       { text: '给个鼓励', value: '给个鼓励' }]"
                       :filter-method="filterTag"
                       filter-placement="bottom-end">
      </el-table-column>
      <el-table-column prop="content" label="内容" min-width="40%">
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" min-width="20%" sortable>
      </el-table-column>
      <el-table-column align="right" label="操作" min-width="30%" fixed="right">
        <template slot="header" slot-scope="scope">
          <el-input v-model="search" size="mini" placeholder="请输入内容关键字">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </template>
        <template slot-scope="scope">
            <el-button type="info" icon="el-icon-chat" plain @click="toReply(scope.row)">回复
            </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :visible.sync="dialogFormVisible" width="50%">
      <el-form ref="form" :model="replyFeedback">
        <el-form-item label="回复用户的反馈">
          <el-input type="textarea" :rows="2" v-model="replyFeedback.adminReply"></el-input>
        </el-form-item>
        <el-form-item style="text-align: center">
          <el-button type="primary" @click="replyThisFeedback">确定</el-button>
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
      search: '',
      feedbackData: [],
      replyFeedback:{},
      cellStyle: {
        'text-align': 'center'
      },
      dialogFormVisible: false
    }
  },
  created: function () {
    this.getFeedbacks()
  },
  methods: {
    filterTag(value, row) {
      return row.type === value;
    },
    filterTag1(value, row){
      return (row.adminReply===null) === value;
    },
    getFeedbacks() {
      this.$axios.post('http://localhost:8080/feedback/getFeedbacks').then(resp => {
        this.feedbackData = resp.data.data
      })
    },
    toReply(row){
      if(row.adminReply!=null){
        this.$confirm('这条反馈已经有回复了, 是否覆盖?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.dialogFormVisible = true
          this.replyFeedback = Object.assign(row);//将数据传入dialog页面
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      }else {
        this.dialogFormVisible = true
        this.replyFeedback = Object.assign(row);//将数据传入dialog页面
      }
    },
    replyThisFeedback(){
      this.replyFeedback.adminId = this.$store.getters.getUserId
      this.$axios.put('http://localhost:8080/feedback/update', this.replyFeedback).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '修改成功!'
          });
          this.dialogFormVisible = false
          this.getFeedbacks()
        }
      })
    }
  }
}
</script>

<style>
</style>

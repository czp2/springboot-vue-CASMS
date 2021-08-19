<template>
  <el-container>
    <el-header style="background-color:cadetblue;height: 60px;opacity: 70%">
    </el-header>
    <el-main style="background-color: whitesmoke;height: 80vh">
      <div style="width: 100%;height: 100%">
        <el-table
            :data="feedbackData.filter(data => !search || data.content.toLowerCase().includes(search.toLowerCase()))"
            height="100%"
            :default-sort="{prop: 'createTime', order: 'descending'}"
            :header-cell-style='cellStyle'
            :cell-style='cellStyle'>
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
              <el-popover
                  placement="right"
                  width="400"
                  trigger="click"
                  v-show="scope.row.adminReply!=null">
                <div>
                  <i class="el-icon-service"></i>
                  <label style="margin-left: 10px">{{ scope.row.adminReply }}</label>
                </div>
                <el-button slot="reference" type="info" icon="el-icon-chat" plain>查看回复
                </el-button>
              </el-popover>
            </template>
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
      search: '',
      feedbackData: [],
      cellStyle: {
        'text-align': 'center'
      },
    }
  },
  created: function () {
    this.getFeedbacks()
  },
  methods: {
    filterTag(value, row) {
      return row.type === value;
    },
    getFeedbacks() {
      this.$axios.post('http://localhost:8080/feedback/getFeedbacksByUserId/' + this.$store.getters.getUserId).then(resp => {
        this.feedbackData = resp.data.data
      })
    },
  }
}
</script>

<style>
</style>

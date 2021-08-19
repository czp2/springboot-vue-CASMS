<template>
  <div id="myChart" style="width: 100%;height: 100%;"></div>
</template>

<script>
export default {
  data () {
    return {
      repairEcharts:[

      ],
    }
  },
  mounted(){
    this.drawLine();
  },
  methods: {
    drawLine(){
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(document.getElementById('myChart'),'dark')
      // 绘制图表
      myChart.setOption({
        title: { text: '电脑售后维修情况(前十位)' },
        tooltip: {},
        xAxis: {
          name: '型号',
          axisLabel:{
            formatter:function(value){
              if(value.length > 6){
                return `${value.slice(0,4)}...`;
              }
              return value;
            }
          },
          data: []
        },
        yAxis: {},
        series: [{
          name: '维修量',
          type: 'bar',
          barWidth: '40%',
          data: []
        }]
      });
      this.$axios.post('http://localhost:8080/computers/getComputersRepair').then(resp => {
        this.repairEcharts = resp.data.data
        myChart.setOption({
          xAxis: {
            data: this.repairEcharts.map(x => {return x.model})
          },
          series: [{
            name: '维修量',
            type: 'bar',
            data: this.repairEcharts.map(x => {return x.count})
          }]
        });
      })
    }
  }
}
</script>

<style scoped>

</style>

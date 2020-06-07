<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="util.MybatisUtils" %>
<%@ page import="dao.HotWordMapper" %>
<%@ page import="model.HotWord" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SqlSession sqlSession = MybatisUtils.getSqlSession();
    HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
    List<HotWord> hotWord = mapper.getHotWord(null);
%>
<html>
<head>
  <title>Title</title>
</head>
<body>
  <div id="container" style="height: 100%"></div>
  <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
  <script type="text/javascript">
      var dom = document.getElementById("container");
      var myChart = echarts.init(dom);
      var app = {};

      app.title = '热搜词';

      var option = {
          tooltip: {
              trigger: 'item',
              formatter: "{a} <br/>{b}: {c} ({d}%)"
          },
          color:['#93D8A9','#FFB99D','#AF7DCC','#FFD83D','#bbe2e8'],
          legend: {
              orient: 'horizontal',
              x: 'left',
              data: [
                  '<%=hotWord.get(0).getKeyword()%>',
                  '<%=hotWord.get(1).getKeyword()%>',
                  '<%=hotWord.get(2).getKeyword()%>',
                  '<%=hotWord.get(3).getKeyword()%>',
                  '<%=hotWord.get(4).getKeyword()%>'
              ]
          },
          series: [{
              name: '热搜词',
              type: 'pie',
              radius: ['10%', '50%'],
              avoidLabelOverlap: false,
              label: {
                  normal: {
                      show: false,
                      position: 'center'
                  },
                  emphasis: {
                      show: true,
                      textStyle: {
                          fontSize: '30',
                          fontWeight: 'bold'
                      }
                  }
              },
              labelLine: {
                  normal: {
                      show: false
                  }
              },
              data: [
                  {value: <%=hotWord.get(0).getTimes()%>, name: '<%=hotWord.get(0).getKeyword()%>'},
                  {value: <%=hotWord.get(1).getTimes()%>, name: '<%=hotWord.get(1).getKeyword()%>'},
                  {value: <%=hotWord.get(2).getTimes()%>, name: '<%=hotWord.get(2).getKeyword()%>'},
                  {value: <%=hotWord.get(3).getTimes()%>, name: '<%=hotWord.get(3).getKeyword()%>'},
                  {value: <%=hotWord.get(4).getTimes()%>, name: '<%=hotWord.get(4).getKeyword()%>'}
              ]
          }]
      };
      if(option && typeof option === "object") {
          myChart.setOption(option, true);
      }
      //mychart.showLoading();//数据加载完之前先显示一段简单的loading动画
  </script>
</body>
</html>

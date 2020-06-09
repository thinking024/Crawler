<%@ page import="controller.RankCrawler" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="util.MybatisUtils" %>
<%@ page import="dao.HotWordMapper" %>
<%@ page import="model.HotWord" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  SqlSession sqlSession = MybatisUtils.getSqlSession();
  HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
  HashMap videoMap = new HashMap();
  videoMap.put("table", "hot_video");
  List<HotWord> hotVideo = mapper.getHotWord(videoMap);

  HashMap userMap = new HashMap();
  userMap.put("table", "hot_user");
  List<HotWord> hotUser = mapper.getHotWord(userMap);
%>
<html>
<head>
  <meta charset="utf-8"/>
  <title>首页</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
  <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body>

<div class="container">
  <div class="row clearfix">
    <div class="col-md-12 column">

      <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd;">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item"><a class="nav-link" href="index.jsp">首页</a></li>
            <li class="nav-item"><a class="nav-link" href="SearchVideo.jsp">视频搜索</a></li>
            <li class="nav-item"><a class="nav-link" href="SearchUser.jsp">up主搜索</a></li>
            <li class="nav-item"><a class="nav-link" href="RankVideo.jsp" tabindex="-1">热搜榜<span class="sr-only">(current)</span></a>
            </li>
          </ul>
        </div>
      </nav>
      <br>
      <div>
        <form class="form-group" action="SearchVideo.jsp" method="get" width="50%" style="float:left">
          <div class="form-inline">
            <input type="text" class="form-control" name="keyword" value="视频搜索" style="float:left">
            <input type="submit" class="btn btn-primary" value="搜索" style="float:left">
          </div>
        </form>

        <form class="form-group" action="SearchUser.jsp" method="get" width="50%" style="float:right">
          <div class="form-inline">
            <input type="text" class="form-control" name="keyword" value="up主搜索">
            <input type="submit" class="btn btn-primary" value="搜索" style="float:left">
          </div>
        </form>
      </div>
    </div>
    <br><br>
  </div>
  <%--饼状图--%>
  <div id="videoContainer" style="height: 80%;width: 50%;float:left"></div>
  <script type="text/javascript" src="../js/echarts.min.js"></script>

  <script type="text/javascript">
      var dom = document.getElementById("videoContainer");
      var myChart = echarts.init(dom);
      var app = {};

      app.title = '热搜词';

      var option = {
          tooltip: {
              trigger: 'item',
              formatter: "{a} <br/>{b}: {c} ({d}%)"
          },
          color: ['#93D8A9', '#FFB99D', '#AF7DCC', '#FFD83D', '#bbe2e8'],
          legend: {
              orient: 'horizontal',
              x: 'left',
              data: [
                  '<%=hotVideo.get(0).getKeyword()%>',
                  '<%=hotVideo.get(1).getKeyword()%>',
                  '<%=hotVideo.get(2).getKeyword()%>',
                  '<%=hotVideo.get(3).getKeyword()%>',
                  '<%=hotVideo.get(4).getKeyword()%>'
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
                  {value: <%=hotVideo.get(0).getTimes()%>, name: '<%=hotVideo.get(0).getKeyword()%>'},
                  {value: <%=hotVideo.get(1).getTimes()%>, name: '<%=hotVideo.get(1).getKeyword()%>'},
                  {value: <%=hotVideo.get(2).getTimes()%>, name: '<%=hotVideo.get(2).getKeyword()%>'},
                  {value: <%=hotVideo.get(3).getTimes()%>, name: '<%=hotVideo.get(3).getKeyword()%>'},
                  {value: <%=hotVideo.get(4).getTimes()%>, name: '<%=hotVideo.get(4).getKeyword()%>'}
              ]
          }]
      };
      if (option && typeof option === "object") {
          myChart.setOption(option, true);
      }

      //mychart.showLoading();//数据加载完之前先显示一段简单的loading动画
  </script>
  <div id="userContainer" style="height: 80%;width: 50%;float:right"></div>
  <script type="text/javascript" src="../js/echarts.min.js"></script>

  <script type="text/javascript">
      var dom = document.getElementById("userContainer");
      var myChart = echarts.init(dom);
      var app = {};

      app.title = '热搜up主';

      var option = {
          tooltip: {
              trigger: 'item',
              formatter: "{a} <br/>{b}: {c} ({d}%)"
          },
          color: ['#93D8A9', '#FFB99D', '#AF7DCC', '#FFD83D', '#bbe2e8'],
          legend: {
              orient: 'horizontal',
              x: 'left',
              data: [
                  '<%=hotUser.get(0).getKeyword()%>',
                  '<%=hotUser.get(1).getKeyword()%>',
                  '<%=hotUser.get(2).getKeyword()%>',
                  '<%=hotUser.get(3).getKeyword()%>',
                  '<%=hotUser.get(4).getKeyword()%>'
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
                  {value: <%=hotUser.get(0).getTimes()%>, name: '<%=hotUser.get(0).getKeyword()%>'},
                  {value: <%=hotUser.get(1).getTimes()%>, name: '<%=hotUser.get(1).getKeyword()%>'},
                  {value: <%=hotUser.get(2).getTimes()%>, name: '<%=hotUser.get(2).getKeyword()%>'},
                  {value: <%=hotUser.get(3).getTimes()%>, name: '<%=hotUser.get(3).getKeyword()%>'},
                  {value: <%=hotUser.get(4).getTimes()%>, name: '<%=hotUser.get(4).getKeyword()%>'}
              ]
          }]
      };
      if (option && typeof option === "object") {
          myChart.setOption(option, true);
      }

      //mychart.showLoading();//数据加载完之前先显示一段简单的loading动画
  </script>
</div>

</body>
</html>

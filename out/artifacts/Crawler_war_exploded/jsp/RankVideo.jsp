<%@ page import="controller.RankCrawler" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String str = "三日排行";
  String url = "https://www.bilibili.com/ranking";
  if (request.getParameter("sel") != null) {
    url = request.getParameter("sel");
    if (url.equals("https://www.bilibili.com/ranking/all/0/0/7")) {
      str = "周排行";
    }
    if (url.equals("https://www.bilibili.com/ranking/all/0/0/1")) {
      str = "日排行";
    }
    if (url.equals("https://www.bilibili.com/ranking/all/0/0/3")) {
      str = "三日排行";
    }
    if (url.equals("https://www.bilibili.com/ranking/all/0/0/30")) {
      str = "月排行";
    }
  }
%>
<html>
<head>
  <meta charset="utf-8"/>
  <title>排行榜</title>
  <style type="text/css">
    a {
      font-size: 18px;
    }

    body {
      background: #F9C;
      background-image: url("../image/bilibili.jpg");
      background-repeat: no-repeat;
      background-position: center;
      background-attachment: fixed;
    }
  </style>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css"
        integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">


</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>

<%
  RankCrawler rankCrawler = new RankCrawler();
  ArrayList<Video> videos = rankCrawler.parseVideoListHtml(url);
%>

<div class="container">
  <div class="row clearfix">
    <div class="col-md-12 column">

      <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd;">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item"><a class="nav-link" href="index.jsp" tabindex="-1">首页<span
                    class="sr-only">(current)</span></a></li>
            <li class="nav-item"><a class="nav-link" href="SearchVideo.jsp">视频搜索</a></li>
            <li class="nav-item"><a class="nav-link" href="SearchUser.jsp">up主搜索</a></li>
            <li class="nav-item"><a class="nav-link" href="RankVideo.jsp">排行榜</a></li>
          </ul>
        </div>
      </nav>
      <br/>
      <form action="RankVideo.jsp" method="post" style="float:right">
        <select class="combobox" name="sel">
          <option value="https://www.bilibili.com/ranking/all/0/0/1">日排行</option>
          <option value="https://www.bilibili.com/ranking/all/0/0/3">三日排行</option>
          <option value="https://www.bilibili.com/ranking/all/0/0/7">周排行</option>
          <option value="https://www.bilibili.com/ranking/all/0/0/30">月排行</option>
        </select>
        <input type="submit" value="筛选">
      </form>
      <h1><%=str%>
      </h1>
      <table class="table table-hover">
        <thead>
        <tr>
          <th>排名</th>
          <th>视频名称</th>
          <th>播放量</th>
          <th>弹幕数量</th>
          <th>up主</th>
          <th>综合得分</th>
        </tr>
        </thead>
        <tbody>
        <% int rank = 1;
          for (Video video : videos) { %>
        <tr>
          <td width="5px"><%=rank%>
          </td>
          <td width="550px"><a style="color:#3CC " href=<%=video.getHref() %>><%=video.getTitle() %>
          </a></td>
          <td width="5px"><%=video.getPlay()%>
          </td>
          <td width="5px"><%=video.getDanmu()%>
          </td>
          <td width="10px"><a style="color:#F9C " href=<%=video.getUpUrl()%>><%=video.getUpName()%>
          </a></td>
          <td width="30px"><%=video.getScore()%>
          </td>
        </tr>
        <%
            rank++;
          }
        %>
        </tbody>
      </table>
    </div>
  </div>
</div>

</body>
</html>

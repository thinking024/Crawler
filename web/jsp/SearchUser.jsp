<%@ page import="util.*" %>
<%@ page import="model.*" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="dao.HotWordMapper" %>
<%@ page import="java.util.*" %>
<%@ page import="controller.UserCrawler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
  request.setCharacterEncoding("utf-8");
  String keyword = null;
  if (request.getParameter("keyword") == null || "".equals(request.getParameter("keyword").trim())) {
    keyword = request.getParameter("keywordHidden"); // 初始页面 搜索空串 输入页码跳转 都走此分支
  } else {
    keyword = request.getParameter("keyword").trim();
  }

  UserCrawler userCrawler = new UserCrawler();
  ArrayList<User> users = null;
  int pageNo = 1; // 当前页号
  int pageNumber = 0; // 总页码
  String order = ""; // 排序方式，默认为综合排序
  if (request.getParameter("order") != null && !("".equals(request.getParameter("order")))) {
    order = "&order=" + request.getParameter("order"); // 赋值为获取到的order参数
  }
  if (keyword != null && !("".equals(keyword))) {
//      爬取页面数据
    String url = "https://search.bilibili.com/upuser?keyword=" + keyword;
    pageNumber = userCrawler.getPageNumber(url); // 获取搜索结果的总页数
    if (request.getParameter("pageNo") != null && !("".equals(request.getParameter("pageNo")))) { // pageNo为跳转的页码数
      pageNo = Integer.valueOf(request.getParameter("pageNo"));
      url = url + "&page=" + pageNo;
    }
    url = url + order;
    System.out.println("url=" + url);
    users = userCrawler.parseUserListHtml(url);
//      实现热搜词汇功能
    SqlSession sqlSession = MybatisUtils.getSqlSession();
    HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
    HashMap map = new HashMap();
    map.put("table", "hot_user");
    map.put("keyword", keyword.toLowerCase());
    List<HotWord> hotWord = mapper.getHotWord(map);
    if (hotWord == null || hotWord.isEmpty()) { // 不存在此热搜词，存入数据库
      int result = mapper.insertHotWord(map);
      System.out.println("result=" + result);
    } else { // 已存在此热搜词，次数+1
      int result = mapper.updateHotWord(map);
      System.out.println("result=" + result);
    }
  }
  SqlSession sqlSession = MybatisUtils.getSqlSession();
  HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
  HashMap map = new HashMap();
  map.put("table", "hot_video");
  List<HotWord> hotWord = mapper.getHotWord(map);
  HashMap userMap = new HashMap();
  userMap.put("table", "hot_user");
  List<HotWord> hotUser = mapper.getHotWord(userMap);
%>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css"
        integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
  <title>用户搜索</title>
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
<div class="container">
  <div class="row clearfix">
    <div class="col-md-12 column">

      <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd;">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item"><a class="nav-link" href="index.jsp" tabindex="-1">首页<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item"><a class="nav-link" href="SearchVideo.jsp">视频搜索</a></li>
            <li class="nav-item"><a class="nav-link" href="SearchUser.jsp">用户搜索</a></li>
            <li class="nav-item"><a class="nav-link" href="RankVideo.jsp">排行榜</a></li>
          </ul>
        </div>
        <form action="SearchUser.jsp" class="form-inline  my-2 my-lg-0">
          <input required="required"  type="search" placeholder="用户搜索" class="form-control mr-sm-2" name="keyword" aria-label="用户搜索">
          <button type="submit" class="btn btn-outline-success my-2 my-sm-0">搜索</button>
        </form>
      </nav>

      热搜视频：
      <%
        for (HotWord word : hotWord) {
          String hotUrl = "SearchVideo.jsp?keyword=" + word.getKeyword();
      %>
      <a class="badge badge-danger" href=<%=hotUrl%>><%=word.getKeyword()%>
      </a>
      <%
        }
      %>
      热搜up主：
      <%
        for (HotWord word : hotUser) {
          String hotUrl1 = "SearchUser.jsp?keyword=" + word.getKeyword();
      %>
      <a class="badge badge-primary" href=<%=hotUrl1%>><%=word.getKeyword()%>
      </a>
      <%
        }
      %>
      <br>
      <%
        if (pageNumber != 0 && users != null && !(users.isEmpty())) {
          // 通过href拼接上order参数
          String all = "SearchUser.jsp?keyword=" + keyword;
          String fans = "SearchUser.jsp?keyword=" + keyword + "&order=fans";
      %>
      <div style="float:right;">
        <a class="badge badge-info" target="_self" href=<%=all%>>综合排序</a>
        <a class="badge badge-info" target="_self" href=<%=fans%>>粉丝数排序</a>
      </div>
      <br>
      <table class="table table-hover">
        <thead>
        <tr>
          <th>up主</th>
          <th>等级</th>
          <th>投稿数量</th>
          <th>粉丝数</th>
          <th>个人简介</th>
        </tr>
        </thead>
        <tbody>
        <%for (User user : users) { %>
        <tr>
          <td width="150px"><a style="color:#F9C " href=<%=user.getHref() %>><%=user.getName() %> <span
                  class="badge badge-primary"><%=user.getVerify()%></span></a></td>
          <td width="100px"><%=user.getLv()%>
          </td>
          <td width="100px"><%=user.getVideos()%>
          </td>
          <td width="100px"><%=user.getFans()%>
          </td>
          <td><%=user.getDescription()%>
          </td>
        </tr>
        <%}%>
        </tbody>
      </table>

      <div>

        <span>当前页码：<%=pageNo%></span><span>(共<%=pageNumber%>页)</span>
        <ul class="pagination" style="float:right;">
          <%String first = "SearchUser.jsp?keyword=" + keyword + order;%>
          <li class="page-item"><a class="page-link" href=<%=first%>> 首页 </a></li>
          <%
            if (pageNo > 1) {
              String previous = "SearchUser.jsp?keyword=" + keyword + order + "&pageNo=" + (pageNo - 1);
          %>
          <li class="page-item"><a class="page-link" href=<%=previous%>>上一页</a></li>
          <%
            }
          %>

          <%
            if (pageNo < pageNumber) {
              String next = "SearchUser.jsp?keyword=" + keyword + order + "&pageNo=" + (pageNo + 1);
          %>
          <li class="page-item"><a class="page-link" href=<%=next%>>下一页</a></li>
          <%
            }
          %>
          <% String last = "SearchUser.jsp?keyword=" + keyword + order + "&pageNo=" + pageNumber;%>
          <li class="page-item"><a class="page-link" href=<%=last%>>末页</a></li>

        </ul>

        <form action="SearchUser.jsp" style="float:right;">

          <%--跳转页面时用到的keyword--%>
          <input type="text" name="keywordHidden" style="display: none" value=<%=keyword%>>
          <%
            if (order != "") // 未采用默认排序，提取出order字符串
              order = order.substring(7);
          %>
          <%--跳转页面时用到的order--%>
          <input type="text" name="order" style="display: none" value=<%=order%>>
          <%--跳转页面时用到的pageNo--%>
          <div class="form-inline">
            <input class="form-control" type="number" name="pageNo" required="required" min="1" max=<%=pageNumber%>>
            <input class="btn btn-primary" type="submit" value="跳到此页">
          </div>

        </form>

      </div>
      <%
      } else { // 没有搜索出结果
      %>
      <div align="center">
        <img src="../image/NoFound.png" alt="没有找到呢" style="background-position:center;">
      </div>
      <%
        }
      %>

    </div>
  </div>
</div>
</body>
</html>
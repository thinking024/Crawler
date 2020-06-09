<%@ page import="util.VideoCrawler" %>
<%@ page import="model.Video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="util.MybatisUtils" %>
<%@ page import="dao.HotWordMapper" %>
<%@ page import="model.HotWord" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("utf-8");
    String keyword = null;
    if (request.getParameter("keyword") == null || "".equals(request.getParameter("keyword").trim())) {
        keyword = request.getParameter("keywordHidden"); // 初始页面 搜索空串 输入页码跳转 都走此分支
    } else {
        keyword = request.getParameter("keyword").trim();
    }
    /*System.out.println("keyword="+keyword);
    System.out.println("requestkeyword="+request.getParameter("keyword"));
    System.out.println("keywordhidden="+request.getParameter("keywordHidden"));*/
    ArrayList<Video> videos = null;
    int pageNo = 1; // 当前页号
    int pageNumber = 0; // 总页码
    String order = ""; // 排序方式，默认为综合排序
    if (request.getParameter("order") != null && !("".equals(request.getParameter("order")))) {
        order = "&order=" + request.getParameter("order"); // 赋值为获取到的order参数
    }
    if (keyword != null && !("".equals(keyword))) {

//      爬取页面数据
        String url = "https://search.bilibili.com/all?keyword=" + keyword + order;
        pageNumber = VideoCrawler.getPageNumber(url); // 获取搜索结果的总页数
        if ( request.getParameter("pageNo") !=null && !("".equals(request.getParameter("pageNo")))) { // pageNo为跳转的页码数
            pageNo = Integer.valueOf(request.getParameter("pageNo"));
            url = url + "&page=" + pageNo;
        }
        System.out.println("url="+url);
        videos = VideoCrawler.parseVideoListHtml(url);

//      实现热搜词汇功能
        SqlSession sqlSession = MybatisUtils.getSqlSession();
        HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
        HashMap map = new HashMap();
        map.put("table","hot_video");
        map.put("keyword",keyword.toLowerCase());
        List<HotWord> hotWord = mapper.getHotWord(map);

        HashMap userMap = new HashMap();
        userMap.put("table","hot_user");
        List<HotWord> hotUser = mapper.getHotWord(userMap);

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
    map.put("table","hot_video");
    List<HotWord> hotWord = mapper.getHotWord(map);
    HashMap userMap = new HashMap();
    userMap.put("table","hot_user");
    List<HotWord> hotUser = mapper.getHotWord(userMap);
%>
<html>
<head>
  <title>Title</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

</head>
<body>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <div class="container">
    		<div class="row clearfix">
    			<div class="col-md-12 column">

    				<nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd;">
    					  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    					    <ul class="navbar-nav mr-auto">
    					      <li class="nav-item"><a class="nav-link" href="/jsp/index.jsp" tabindex="-1">首页<span class="sr-only">(current)</span></a></li>
                              <li class="nav-item"><a class="nav-link" href="/jsp/SearchVideo.jsp">视频搜索</a></li>
                              <li class="nav-item"><a class="nav-link" href="/jsp/SearchUser.jsp">up主搜索</a></li>
                              <li class="nav-item"><a class="nav-link" href="/jsp/RankVideo.jsp">热搜榜</a></li>
    					    </ul>
    					  </div>
    					  <form action="SearchVideo.jsp" style="float:right">
                              <div class="form-inline">
                                  <input type="text" class="form-control" name="keyword" value="视频搜索" style="float:left">
                                  <input type="submit" class="btn btn-primary" value="搜索" style="float:left">
                              </div>
                           </form>
    				</nav>

    热搜视频：
  <%
    for (HotWord word : hotWord) {
      String hotUrl = "SearchVideo.jsp?keyword=" + word.getKeyword();
  %>
      <a href=<%=hotUrl%> class="badge badge-danger"><%=word.getKeyword()%></a>
  <%
    }
  %>
     热搜up主：
     <%
       for (HotWord word : hotUser) {
         String hotUrl1 = "SearchUser.jsp?keyword=" + word.getKeyword();
     %>
           <a href=<%=hotUrl1%> class="badge badge-primary"><%=word.getKeyword()%></a>
     <%
       }
     %>
    <br>
<%
  if (pageNumber != 0) {
      // 通过href拼接上order参数
      String all = "SearchVideo.jsp?keyword=" + keyword;
      String click = "SearchVideo.jsp?keyword=" + keyword + "&order=click";
      String pubdate = "SearchVideo.jsp?keyword=" + keyword + "&order=pubdate";
%>
       <div style="float:right;">
      <a class="badge badge-info" target="_self" href=<%=all%>>综合排序</a>
      <a class="badge badge-info" target="_self" href=<%=click%>>最多点击</a>
      <a class="badge badge-info" target="_self" href=<%=pubdate%>>最新发布</a>
      </div>
      <br>
      <table class="table table-hover">
          <thead>
              <tr>
                  <th >视频名称</th>
                  <th >投稿时间</th>
                  <th >播放量</th>
                  <th >弹幕数量</th>
                  <th >长度</th>
                  <th >up主</th>
                  <th>简介</th>
              </tr>
          </thead>
          <tbody>
              <% for(Video video : videos){ %>
              <tr>
                  <td width="300px"><a style="color:#3CC " href=<%=video.getHref() %> ><%=video.getTitle() %> </a></td>
                  <td width="5%"><%=video.getUploadTime()%></td>
                  <td width="1px"><%=video.getPlay()%></td>
                  <td width="1px"><%=video.getDanmu()%></td>
                  <td width="1px"><%=video.getLength()%></td>
                  <td width="1px"><a style="color:#F9C " href=<%=video.getUpUrl()%> ><%=video.getUpName()%> </a></td>
                  <td width="200px" ><%=video.getDescription()%></td>
              </tr>
              <%}%>
          </tbody>
      </table>

      <div >
          <form action="SearchVideo.jsp" style="float:right;" >

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
             <span>当前页码：<%=pageNo%></span><span>(共<%=pageNumber%>页)</span>
            <ul class="pagination"  style="float:right;" >
             <%String first =  "SearchVideo.jsp?keyword=" + keyword + order;%>
             <li class="page-item"><a class="page-link" href=<%=first%> > 首页 </a></li>
            <%
              if (pageNo > 1) {
                String previous = "SearchVideo.jsp?keyword=" + keyword + order + "&pageNo=" + (pageNo-1);
            %>
            <li class="page-item"><a class="page-link" href=<%=previous%>>上一页</a></li>
            <%
              }
            %>

            <%
              if (pageNo < pageNumber) {
                String next = "SearchVideo.jsp?keyword=" + keyword + order + "&pageNo=" + (pageNo+1);
            %>
            <li class="page-item"><a class="page-link" href=<%=next%>>下一页</a></li>
            <%
              }
            %>
            <% String last =  "SearchVideo.jsp?keyword=" + keyword + order + "&pageNo=" + pageNumber;%>
            <li class="page-item"><a class="page-link" href=<%=last%>>末页</a></li>

           </ul>


          </div>



<%
    } else { // 没有搜索出结果
%>
    <img src="../image/NoFound.png" alt="没有找到呢" style="background-position:center;">
<%
    }
%>
</div>
</div>
</div>
</body>
</html>
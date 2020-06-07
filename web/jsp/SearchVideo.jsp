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
        List<HotWord> hotWord = mapper.getHotWord(keyword.toLowerCase());
        HashMap map = new HashMap();
        map.put("table","hot_video");
        map.put("keyword",keyword.toLowerCase());
        if (hotWord == null || hotWord.isEmpty()) {
            int result = mapper.insertHotWord(map);
            System.out.println("result=" + result);
        } else {
            int result = mapper.updateHotWord(map);
            System.out.println("result=" + result);
        }

    }

    SqlSession sqlSession = MybatisUtils.getSqlSession();
    HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
    List<HotWord> hotWord = mapper.getHotWord(null);
%>
<html>
<head>
  <title>Title</title>
</head>
<body>
  <form action="SearchVideo.jsp">
    <input type="text" name="keyword" required="required" onkeyup="this.value=this.value.replace(/[, ]/g,'')">
    <input type="submit">
  </form>

  <%
    for (HotWord word : hotWord) {
      String hoturl = "SearchVideo.jsp?keyword=" + word.getKeyword();
  %>
      <a href=<%=hoturl%>>
        <%=word.getKeyword()%>
      </a>
      <br>
  <%
    }
  %>

<%
  if (pageNumber != 0) {

      // 通过href拼接上order参数
      String all = "SearchVideo.jsp?keyword=" + keyword;
      String click = "SearchVideo.jsp?keyword=" + keyword + "&order=click";
      String pubdate = "SearchVideo.jsp?keyword=" + keyword + "&order=pubdate";
%>
      <a target="_self" href=<%=all%>>综合排序</a>
      <a target="_self" href=<%=click%>>最多点击</a>
      <a target="_self" href=<%=pubdate%>>最新发布</a>
<%
      for (Video video : videos) {
%>
      <div>
        <a href=<%=video.getHref()%>>
          title=<%=video.getTitle()%>
        </a>
        <a href=<%=video.getUpUrl()%>> up=<%=video.getUpName()%> </a>
        <span>time=<%=video.getUploadTime()%></span>
        <span>play=<%=video.getPlay()%></span>
        <span>danmu=<%=video.getDanmu()%></span>
        <span>length=<%=video.getLength()%></span>
        <span>des=<%=video.getDescription()%></span>
      </div>
      <br>
<%
      }
%>
      <div>
        <span>当前页码：<%=pageNo%></span>
        <span>共<%=pageNumber%>页</span>
        <% String first =  "SearchVideo.jsp?keyword=" + keyword + order;%>
        <a href=<%=first%>>首页</a>
        <% String last =  "SearchVideo.jsp?keyword=" + keyword + order + "&pageNo=" + pageNumber;%>
        <a href=<%=last%>>末页</a>
        
        <%
            if (pageNo > 1) {
                String previous = "SearchVideo.jsp?keyword=" + keyword + order + "&pageNo=" + (pageNo-1);
        %>
                <a href=<%=previous%>>上一页</a>
        <%
            }
        %>

        <%
            if (pageNo < pageNumber) {
                String next = "SearchVideo.jsp?keyword=" + keyword + order + "&pageNo=" + (pageNo+1);
        %>
                <a href=<%=next%>>下一页</a>
        <%
            }
        %>
      </div>

      <form action="SearchVideo.jsp">

        <%--跳转页面时用到的keyword--%>
        <input type="text" name="keywordHidden" style="display: none" value=<%=keyword%>>
        <%
          if (order != "") // 未采用默认排序，提取出order字符串
              order = order.substring(7);
        %>
          <%--跳转页面时用到的order--%>
        <input type="text" name="order" style="display: none" value=<%=order%>>
          <%--跳转页面时用到的pageNo--%>
        <input type="number" name="pageNo" required="required" min="1" max=<%=pageNumber%>>
        <input type="submit" value="跳到此页">
      </form>

<%
  } else { // 没有搜索出结果
%>
      <img src="../image/NoFound.png" alt="没有找到呢">
<%
  }
%>
</body>
</html>

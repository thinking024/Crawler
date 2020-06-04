<%@ page import="util.VideoCrawler" %>
<%@ page import="java.util.HashSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = "https://search.bilibili.com/all?keyword=" + request.getParameter("keyword");
    VideoCrawler videoCrawler = new VideoCrawler();
%>
<html>
<head>
  <title>Title</title>
</head>
<body>
<%
  HashSet hashSet = VideoCrawler.parseVideoHtml(url);
  out.println(hashSet);
  //for (Object o : hashSet) {
%>
<%--  <a href=<%=o%> > <%=o%> </a>
<%
  }
%>--%>

</body>
</html>

<%@ page import="util.UserCrawler" %>
<%@ page import="model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String keyword = request.getParameter("keyword");
  String url = "https://search.bilibili.com/upuser?keyword=" + keyword;
  ArrayList<User> users = UserCrawler.parseUserListHtml(url);
%>
<html>
<head>
  <title>Title</title>
</head>
<body>
  <form action="SearchUser.jsp">
    <input type="text" name="keyword">
    <input type="submit">
  </form>
<%
  if (users != null) {
      for (User user : users) {
%>
      <div>
        <a href=<%=user.getHref()%>>
          <%=user.getName()%>
        </a>
        <span>lv=<%=user.getLv()%></span>
        <span>videos=<%=user.getVideos()%></span>
        <span>fans=<%=user.getFans()%></span>
        <span>desc=<%=user.getDescription()%></span>
        <span>verify=<%=user.getVerify()%></span>
      </div>
<%
      }
  }
%>
</body>
</html>

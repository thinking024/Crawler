<%@ page import="util.VideoCrawler" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = "https://search.bilibili.com/all?keyword=" + request.getParameter("keyword");

%>
<html>
<head>
  <title>Title</title>
</head>
<body>
<%
  ArrayList<Video> videos = VideoCrawler.parseVideoListHtml(url);
//  out.println(videos);
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

</body>
</html>

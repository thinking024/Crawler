<%@ page import="util.RankCrawler" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String str="三日排行";
    String url = "https://www.bilibili.com/ranking";
    if (request.getParameter("sel") != null) {
        url=request.getParameter("sel");
        if(url.equals("https://www.bilibili.com/ranking/all/0/0/7")){
            str="周排行";
        }
        if(url.equals("https://www.bilibili.com/ranking/all/0/0/1")){
            str="日排行";
        }
        if(url.equals("https://www.bilibili.com/ranking/all/0/0/3")){
            str="三日排行";
        }
        if(url.equals("https://www.bilibili.com/ranking/all/0/0/30")){
            str="月排行";
        }
    }
%>
<html>
<head>
  <title>Title</title>
    <meta charset="utf-8" />
    <title>排行榜</title>
    <style type="text/css">
        a{font-size:18px;}
        body {
            background: #F9C;
        	background-image: url("../image/bilibili.jpg");
        	background-repeat: no-repeat;
        	background-position: center;
        	background-attachment: fixed;
        }
    </style
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body >

<%
  ArrayList<Video> videos = RankCrawler.parseVideoListHtml(url);
%>

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
				</nav>
				<br/>
				<form action="RankVideo.jsp" method="get">
                <select class="combobox" name="sel">
                  <option value="https://www.bilibili.com/ranking/all/0/0/1">日排行</option>
                  <option value="https://www.bilibili.com/ranking/all/0/0/3">三日排行</option>
                  <option value="https://www.bilibili.com/ranking/all/0/0/7">周排行</option>
                  <option value="https://www.bilibili.com/ranking/all/0/0/30">月排行</option>
                </select>
                <input type="submit" value="筛选">
                </form>
                <h1><%=str%></h1>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th >排名</th>
                            <th >视频名称</th>
                            <th >播放量</th>
                            <th >弹幕数量</th>
                            <th >up主</th>
                            <th >综合得分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int rank=1;  for(Video video : videos){ %>
                        <tr>
                            <td width="5px"><%=rank%></td>
                            <td width="550px"><a style="color:#3CC " href=<%=video.getHref() %> ><%=video.getTitle() %> </a></td>
                            <td width="5px"><%=video.getPlay()%></td>
                            <td width="5px"><%=video.getDanmu()%></td>
                            <td width="10px"><a style="color:#F9C " href=<%=video.getUpUrl()%> ><%=video.getUpName()%> </a></td>
                            <td width="30px"><%=video.getScore()%></td>
                        </tr>
                        <%rank++;}%>
                    </tbody>
                </table>
			</div>
		</div>
	</div>

</body>
</html>

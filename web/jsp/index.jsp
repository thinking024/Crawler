<%@ page import="util.RankCrawler" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>index</title>
    <meta charset="utf-8" />
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body >

    <div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">

				<nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd;">
					  <div class="collapse navbar-collapse" id="navbarSupportedContent">
					    <ul class="navbar-nav mr-auto">
					      <li class="nav-item"><a class="nav-link" href="/jsp/index.jsp">首页</a></li>
					      <li class="nav-item"><a class="nav-link" href="/jsp/SearchVideo.jsp">视频搜索</a></li>
						  <li class="nav-item"><a class="nav-link" href="/jsp/SearchUser.jsp">up主搜索</a></li>
					      <li class="nav-item"><a class="nav-link" href="/jsp/RankVideo.jsp" tabindex="-1">热搜榜<span class="sr-only">(current)</span></a></li>
					    </ul>
					  </div>
				</nav>
                <form action="/jsp/SearchVideo.jsp" method="get">
                <input type="text" name="keyword" value="视频搜索">
                <input type="submit" value="搜索">
                </form>

                <form action="/jsp/SearchUser.jsp" method="get">
                <input type="text" name="keyword" value="up主搜索">
                <input type="submit" value="搜索">
                </form>

			</div>
		</div>
	</div>

</body>
</html>

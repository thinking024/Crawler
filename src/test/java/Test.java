//import controller.GithubRepoPageProcessor;
//import controller.SinaBlogProcessor;
import dao.HotWordMapper;
import model.HotWord;
import model.User;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
//import us.codecraft.webmagic.Spider;
//import us.codecraft.webmagic.pipeline.JsonFilePipeline;
import org.apache.ibatis.session.SqlSession;
import util.MybatisUtils;
import util.UserCrawler;
import util.VideoCrawler;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class Test {

    /*@org.junit.Test
    public void test() {
        Spider.create(new GithubRepoPageProcessor())
                //从"https://github.com/code4craft"开始抓
                .addUrl("https://github.com/code4craft")
                .addPipeline(new JsonFilePipeline("E:\\test\\"))
                //开启5个线程抓取
                .thread(5)
                //启动爬虫
                .run();
    }*/
    
    @org.junit.Test
    public void testHttpClient() {
        //建立一个新的请求客户端
        CloseableHttpClient httpClient= HttpClients.createDefault();

        //使用HttpGet的方式请求网址
        HttpGet httpGet = new HttpGet("http://space.bilibili.com/517327498");

        httpGet.setHeader("Accept", "Accept text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");

        httpGet.setHeader("Accept-Charset", "GB2312,utf-8;q=0.7,*;q=0.7");

        httpGet.setHeader("Accept-Encoding", "gzip, deflate");

        httpGet.setHeader("Accept-Language", "zh-cn,zh;q=0.5");

        httpGet.setHeader("Connection", "keep-alive");

        httpGet.setHeader("Cookie", "__utma=226521935.73826752.1323672782.1325068020.1328770420.6;");

        httpGet.setHeader("Host", "space.bilibili.com");

        //httpGet.setHeader("refer", "http://www.baidu.com/s?tn=monline_5_dg&bs=httpclient4+MultiThreadedHttpConnectionManager");

        httpGet.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; rv:6.0.2) Gecko/20100101 Firefox/6.0.2");
        //httpGet.setHeader("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31"); // 设置请求头消息User-Agent

        HttpHost proxy = new HttpHost("112.85.168.223", 9999);
        RequestConfig config = RequestConfig.custom().setProxy(proxy).build();
        httpGet.setConfig(config);

        //获取网址的返回结果
        CloseableHttpResponse response=null;
        try {
            response=httpClient.execute(httpGet);
        } catch (IOException e) {
            e.printStackTrace();
        }

        //获取返回结果中的实体
        HttpEntity entity = response.getEntity();

        //将返回的实体输出
        try {
            System.out.println(EntityUtils.toString(entity));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /*@org.junit.Test
    public void testVideoCrawler() {
        ArrayList<Video> videos = VideoCrawler.getPageNumber("https://search.bilibili.com/all?keyword=kpl");
        for (Video video : videos) {
            System.out.println(video);
        }
    }*/

    @org.junit.Test
    public void test_parseVideoInfoHtml() {
        System.out.println(VideoCrawler.parseVideoInfoHtml("https://"+ "www.bilibili.com/video/BV19C4y1W7th"));
    }

    @org.junit.Test
    public void test_getVideoHtml() {
        VideoCrawler.getHtml("https://search.bilibili.com/all?keyword=kpl");


    }

    @org.junit.Test
    public void test_parseUpListHtml() {
        ArrayList<User> users = UserCrawler.parseUserListHtml("https://search.bilibili.com/upuser?keyword=计算机");
        for (User user : users) {
            System.out.println(user);
        }
    }

    @org.junit.Test
    public void test_pageNumber() {
        System.out.println(VideoCrawler.getPageNumber("https://search.bilibili.com/all?keyword=987987"));
    }

    @org.junit.Test
    public void jdbc() {
        Connection connection = null;
        Statement statement = null;

        String driver="com.mysql.jdbc.Driver";

        String url="jdbc:mysql://47.107.103.168:3306/mysql?&useSSL=false&serverTimezone=UTC";
        String user="root";
        String password="root";
            try {
                //注册JDBC驱动程序
                Class.forName(driver);
                //建立连接
                connection = DriverManager.getConnection(url, user, password);
                statement = connection.createStatement();
                if (!connection.isClosed()) {
                    System.out.println("数据库连接成功");
                }
            } catch (ClassNotFoundException e) {
                System.out.println("数据库驱动没有安装");

            } catch (SQLException e) {
                e.printStackTrace();
            }
    }

    @org.junit.Test
    public void test_getBlogs() {
        SqlSession sqlSession = MybatisUtils.getSqlSession();
        HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
        for (HotWord hotWord : mapper.getHotWord(null)) {
            System.out.println(hotWord);
        }
        // Mybatis默认开启一级缓存，一级缓存的范围是SqlSession。
        //sqlSession.clearCache();
        sqlSession.close();
    }

    @org.junit.Test
    public void test_insertBlogSet() {
        SqlSession sqlSession = MybatisUtils.getSqlSession();
        HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
        HashMap map = new HashMap();
        map.put("table","hot_video");
        map.put("keyword","math");
        int lines = mapper.insertHotWord(map);
        sqlSession.close();
    }

    @org.junit.Test
    public void test_updateBlogSet() {
        SqlSession sqlSession = MybatisUtils.getSqlSession();
        HotWordMapper mapper = sqlSession.getMapper(HotWordMapper.class);
        HashMap map = new HashMap();
        map.put("table","hot_video");
        map.put("keyword","math");
        int lines = mapper.updateHotWord(map);
        sqlSession.close();
    }

}

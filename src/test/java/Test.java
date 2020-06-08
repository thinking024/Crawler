//import controller.GithubRepoPageProcessor;
//import controller.SinaBlogProcessor;
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
<<<<<<< HEAD
import util.RankCrawler;
=======
import util.UserCrawler;
>>>>>>> 526449b041a6fcaefb212a50bb8d850fe50c7947
import util.VideoCrawler;

import java.io.IOException;
import java.util.ArrayList;

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
        System.out.println(VideoCrawler.getHtml("https://"+ "www.bilibili.com/video/BV19C4y1W7th"));
    }

    @org.junit.Test
    public void test_getVideoHtml() {
        VideoCrawler.getHtml("https://search.bilibili.com/all?keyword=kpl");
<<<<<<< HEAD
    }

    public static void main(String[] args) {
        RankCrawler.parseVideoListHtml("https://www.bilibili.com/ranking");
    }
}
=======


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

}
>>>>>>> 526449b041a6fcaefb212a50bb8d850fe50c7947

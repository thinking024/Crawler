package util;

import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.HashSet;

public class VideoCrawler {
    public static String getVideoHtml(String url) {
        // 建立一个请求客户端
        CloseableHttpClient httpClient= HttpClients.createDefault();
        // 使用HttpGet的方式请求网址
        HttpGet httpGet = new HttpGet(url);
        // 设置请求头
        httpGet.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; rv:6.0.2) Gecko/20100101 Firefox/6.0.2");
        // 获取网址的返回结果
        CloseableHttpResponse response=null;
        try {
            response=httpClient.execute(httpGet);
            // 获取返回结果中的实体
            HttpEntity entity = response.getEntity();
            return EntityUtils.toString(entity);
        } /*catch (ClientProtocolException e) {
            e.printStackTrace();
        }*/ catch (IOException e) {
            e.printStackTrace();
        } finally {
            HttpClientUtils.closeQuietly(response);
            HttpClientUtils.closeQuietly(httpClient);
        }

        return null;
    }

    public static HashSet parseVideoHtml(String url) {
        HashSet hashSet = new HashSet();
        String html = getVideoHtml(url);
        Document document = Jsoup.parse(html);
        Elements elements = document.getElementsByClass("video-item matrix"); // 按类名获取视频列表
        for (Element element : elements) {
            System.out.println(element);
            Element select = element.select("a[href]").first(); // 获取每个视频列表中的<a href ></a>标签对
            String href = select.attr("href"); // 提取视频链接
            int index = href.indexOf("?");
            System.out.println(href.substring(2, index)); // 处理链接中多余的符号
            hashSet.add(href.substring(2, index));
            System.out.println("");
        }
        return hashSet;
    }
}

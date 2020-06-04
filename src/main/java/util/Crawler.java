package util;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class Crawler {
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
}

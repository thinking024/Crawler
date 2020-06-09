package controller;

import model.Video;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;

public class VideoCrawler extends Crawler {
    // 解析爬取到的结果
    public ArrayList<Video> parseVideoListHtml(String url) {

        ArrayList<Video> videoList =  new ArrayList<Video>();
        String html = getHtml(url);
        Document document = Jsoup.parse(html);
        Elements elements = document.getElementsByClass("video-item matrix"); // 按类名获取视频列表

        for (Element element : elements) { // 对每个视频提取数据，并把数据存在Video类中

            Video video = new Video();

            String href = element.selectFirst("a[href]").attr("href"); // 提取视频链接
            int index_href = href.indexOf("?");
            String realHref = "https://"+ href.substring(2, index_href);// 处理链接中多余的符号
            video.setHref(realHref);

            String title = element.selectFirst("a[href]").attr("title");
            video.setTitle(title);

            String play = element.selectFirst("[title=\"观看\"]").text();
            video.setPlay(play);

            String danmu = element.selectFirst("[title=\"弹幕\"]").text();
            video.setDanmu(danmu);

            String uploadTime = element.selectFirst("[title=\"上传时间\"]").text();
            video.setUploadTime(uploadTime);

            Element up = element.getElementsByClass("up-name").first();

            String upName = up.text();
            video.setUpName(upName);

            String upUrl = up.attr("href");
            int index_upUrl = upUrl.indexOf("?");
            String realupUrl = "https://"+ upUrl.substring(2, index_upUrl);// 处理链接中多余的符号
            video.setUpUrl(realupUrl);

            String length = element.getElementsByClass("so-imgTag_rb").first().text();
            video.setLength(length);

            String description = element.getElementsByClass("des hide").first().text();
            video.setDescription(description);

            videoList.add(video);
        }
        return videoList;
    }
}
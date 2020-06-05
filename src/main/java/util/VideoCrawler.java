package util;

import model.Video;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.HashMap;

public class VideoCrawler extends Crawler {

    // 解析爬取到的结果
    public static ArrayList<Video> parseVideoListHtml(String url) {

        ArrayList<Video> videoList =  new ArrayList<Video>();
        String html = getHtml(url);
        Document document = Jsoup.parse(html);
        Elements elements = document.getElementsByClass("video-item matrix"); // 按类名获取视频列表
//        System.out.println(document.getElementsByClass("page-item last").text());  获取页码
        for (Element element : elements) { // 对每个视频提取数据，并把数据存在Video类中
//            System.out.println(element);

            Video video = new Video();

            String href = element.selectFirst("a[href]").attr("href"); // 提取视频链接
            int index_href = href.indexOf("?");
            String realHref = "https://"+ href.substring(2, index_href);// 处理链接中多余的符号
            video.setHref(realHref);

//            System.out.println(realHref);

            String title = element.selectFirst("a[href]").attr("title");
            video.setTitle(title);

//            System.out.println(title);

            String play = element.selectFirst("[title=\"观看\"]").text();
            video.setPlay(play);

//            System.out.println(play);

            String danmu = element.selectFirst("[title=\"弹幕\"]").text();
            video.setDanmu(danmu);

//            System.out.println(danmu);

            String uploadTime = element.selectFirst("[title=\"上传时间\"]").text();
            video.setUploadTime(uploadTime);

//            System.out.println(uploadTime);

            Element up = element.getElementsByClass("up-name").first();
            //System.out.println(up);
            String upName = up.text();
            video.setUpName(upName);

            String upUrl = up.attr("href");
            int index_upUrl = upUrl.indexOf("?");
            String realupUrl = "https://"+ upUrl.substring(2, index_upUrl);// 处理链接中多余的符号
            video.setUpUrl(realupUrl);

            /*System.out.println(upName);
            System.out.println(realupUrl);*/

            String length = element.getElementsByClass("so-imgTag_rb").first().text();
            video.setLength(length);

            //System.out.println(length);

            String description = element.getElementsByClass("des hide").first().text();
            video.setDescription(description);

            //System.out.println(description);

            /*String image = parseVideoInfoHtml(realHref);
            video.setImage(image);
            System.out.println(image+"\n\n\n");*/

            videoList.add(video);
        }
        return videoList;
    }

    public static String parseVideoInfoHtml(String url) {
        String html = getHtml(url);
        Document document = Jsoup.parse(html);
       /* System.out.println(document);

        String title = document.getElementsByClass("tit").first().text();
        System.out.println(title);

        String uploadTime = document.getElementsByClass("video-data").first()
                .getElementsByTag("span").last().text();
        System.out.println(uploadTime);

        String play = document.getElementsByClass("video-data").last()
                .getElementsByClass("view").first().text();
        System.out.println(play);

        String danmu = document.getElementsByClass("video-data").last()
                .getElementsByClass("dm").first().text();
        System.out.println(danmu);

        String introduction = document.getElementsByClass("info open").first().text();
        System.out.println(introduction);
        String up = document.selectFirst("[itemprop=author]").attr("content");
        System.out.println(up); */

        String image = document.selectFirst("[itemprop=image]").attr("content");

        return image;
    }
}

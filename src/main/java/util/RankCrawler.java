package util;

import model.Video;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;

public class RankCrawler extends Crawler {

    public static ArrayList<Video> parseVideoListHtml(String url) {

        ArrayList<Video> videoList =new ArrayList<Video>();
        String html = getHtml(url);
        Document document = Jsoup.parse(html);
        Elements elements = document.getElementsByClass("rank-item"); // 按类名获取视频列表

        for (Element element : elements) { // 对每个视频提取数据，并把数据存在Video类中
            Video video = new Video();
            String title = element.getElementsByClass("title").first().text();
            video.setTitle(title);

            String href = element.selectFirst("a[href]").attr("href"); // 提取视频链接
            video.setHref(href);

            Elements data_box= element.getElementsByClass("data-box");
            video.setPlay(data_box.get(0).text());
            video.setDanmu(data_box.get(1).text());
            video.setUpName(data_box.get(2).text());

            Elements uphrefs = element.getElementsByClass("detail");
            for(Element uphreff : uphrefs){
                String uphref = uphreff.selectFirst("a[href]").attr("href"); // 提取up个人空间链接
                video.setUpUrl(uphref);
            }
            String score = element.getElementsByClass("pts").text();
            String realScore = score.substring(0,score.indexOf(" "));
            video.setScore(realScore);

            videoList.add(video);
        }
        return videoList;
    }
}

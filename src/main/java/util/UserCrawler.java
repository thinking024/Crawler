package util;

import model.User;
import model.Video;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;

public class UserCrawler extends Crawler {
    public static ArrayList<User> parseUserListHtml(String url) {

        ArrayList<User> userList =new ArrayList<User>();
        String html = getHtml(url);
        Document document = Jsoup.parse(html);
        Elements elements = document.getElementsByClass("user-item"); // 获取up集合
        for (Element element : elements) {
            System.out.println(element);
            User user = new User();
            String href = element.selectFirst("a[href]").attr("href"); // 提取Up链接
            int index_href = href.indexOf("?");
            String realHref = "https://"+ href.substring(2, index_href);// 处理链接中多余的符号
            user.setHref(realHref);
            System.out.println(realHref);

            String name = element.selectFirst("a[href]").attr("title");
            user.setName(name);
            System.out.println(name);

            String lv = element.getElementsByClass("lv").toString().substring(20,21);
            user.setLv(lv);
            System.out.println(lv);

            String info = element.getElementsByClass("up-info clearfix").first().text();
            int split = info.indexOf("粉");
            String videos = info.substring(0,split);
            String fans = info.substring(split);
            user.setVideos(videos);
            user.setFans(fans);
            System.out.println(videos);
            System.out.println(fans);

            String description = element.getElementsByClass("desc").text();
            user.setDescription(description);
            System.out.println(description);

            //System.out.println(element.getElementsByClass("verify-icon").first().attr("a"));
            if (element.getElementsByClass("verify-icon").first() != null) {
                String verify = element.getElementsByClass("verify-icon").first().attr("title");
                user.setVerify(verify);
                System.out.println(verify);
            }

            userList.add(user);
        }
        return userList;
    }
}

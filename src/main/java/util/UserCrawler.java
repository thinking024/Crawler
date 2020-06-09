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
            User user = new User();
            String href = element.selectFirst("a[href]").attr("href"); // 提取Up链接
            int index_href = href.indexOf("?");
            String realHref = "https://"+ href.substring(2, index_href);// 处理链接中多余的符号
            user.setHref(realHref);

            String name = element.selectFirst("a[href]").attr("title");
            user.setName(name);

            String lv = element.getElementsByClass("lv").toString().substring(20,21);
            user.setLv(lv);

            String info = element.getElementsByClass("up-info clearfix").first().text();
            int split = info.indexOf("粉");
            String videos = info.substring(0,split);
            String fans = info.substring(split);
            user.setVideos(videos.substring(videos.indexOf("：")+1,videos.length() ));
            user.setFans(fans.substring(fans.indexOf("：")+1,fans.length() ));

            String description = element.getElementsByClass("desc").text();
            user.setDescription(description);

            //System.out.println(element.getElementsByClass("verify-icon").first().attr("a"));
            if (element.getElementsByClass("verify-icon").first() != null) {
                String verify = element.getElementsByClass("verify-icon").first().attr("title");
                user.setVerify(verify);
            }

            userList.add(user);
        }
        return userList;
    }
}

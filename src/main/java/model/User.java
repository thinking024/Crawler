package model;

public class User {
    private String name;
    private String href;
    private String lv; // 用户等级
    private String videos; // 用户投稿数
    private String fans; // 粉丝数
    private String description; // 个人简介
    private String verify; // 账号认证信息

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getLv() {
        return lv;
    }

    public void setLv(String lv) {
        this.lv = lv;
    }

    public String getVideos() {
        return videos;
    }

    public void setVideos(String videos) {
        this.videos = videos;
    }

    public String getFans() {
        return fans;
    }

    public void setFans(String fans) {
        this.fans = fans;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getVerify() {
        return verify;
    }

    public void setVerify(String verify) {
        this.verify = verify;
    }

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", href='" + href + '\'' +
                ", lv='" + lv + '\'' +
                ", videos=" + videos +
                ", fans='" + fans + '\'' +
                ", description='" + description + '\'' +
                ", verify='" + verify + '\'' +
                '}';
    }
}

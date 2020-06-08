package model;

import com.sun.xml.internal.ws.api.ha.StickyFeature;
import com.sun.xml.internal.ws.message.StringHeader;

public class Video {
    private String href;                //网址
    private String title;               //标题
    private String play;                //视频播放量
    private String danmu;               //弹幕数量
    private String uploadTime;          //上传时间
    private String upName;              //up主名字
    private String upUrl;               //个人空间
    private String length;              //视频长度
    private String description;         //视频简介
    private String image;               //图片地址

    private String score;               //综合得分


    public String getScore() { return score; }
    public void setScore(String score) { this.score=score; }

    public String getHref() {
        return href;
    }
    public void setHref(String href) {
        this.href = href;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getPlay() {
        return play;
    }
    public void setPlay(String play) {
        this.play = play;
    }

    public String getDanmu() {
        return danmu;
    }
    public void setDanmu(String danmu) {
        this.danmu = danmu;
    }

    public String getUploadTime() {
        return uploadTime;
    }
    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getUpName() {
        return upName;
    }
    public void setUpName(String upName) {
        this.upName = upName;
    }

    public String getUpUrl() {
        return upUrl;
    }
    public void setUpUrl(String upUrl) {
        this.upUrl = upUrl;
    }

    public String getLength() {
        return length;
    }
    public void setLength(String length) {
        this.length = length;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Video{" +
                "href='" + href + '\'' +
                ", title='" + title + '\'' +
                ", play='" + play + '\'' +
                ", danmu='" + danmu + '\'' +
                ", uploadTime='" + uploadTime + '\'' +
                ", upName='" + upName + '\'' +
                ", upUrl='" + upUrl + '\'' +
                ", length='" + length + '\'' +
                ", description='" + description + '\'' +
                ", image='" + image + '\'' +
                ", score='" + score + '\'' +
                '}';
    }

}

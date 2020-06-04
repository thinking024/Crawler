package model;

public class Video {
    private String href;
    private String title;
    private String play;
    private String danmu;
    private String uploadTime;
    private String upName;
    private String upUrl;
    private String length;
    private String description;
    private String image;

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
                '}';
    }
}

package model;

public class HotWord {
    private String keyword;
    private int times;

    public HotWord() {

    }

    public HotWord(String keyword, int times) {
        this.keyword = keyword;
        this.times = times;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }

    @Override
    public String toString() {
        return "HotWord{" +
                "keyword='" + keyword + '\'' +
                ", times=" + times +
                '}';
    }
}

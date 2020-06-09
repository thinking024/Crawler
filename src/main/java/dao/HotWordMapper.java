package dao;

import model.HotWord;

import java.util.*;

public interface HotWordMapper {
    List<HotWord> getHotWord(Map map);
    int insertHotWord(Map map);
    int updateHotWord(Map map);
}

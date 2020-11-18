/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import ogani.model.StarModel;

/**
 *
 * @author Bang-GoD
 */
public class ChartAdmin1 {

//    private static StarModel starModel=new StarModel();
//    static Map<Object, Object> map = null;
//    static List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
//    static List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
//    private static float count=(float)starModel.totalCount()/100;
//    static {
//        map = new HashMap<Object, Object>();
//        map.put("name", "1 Sao");
//        map.put("y", (float)starModel.countOne()/count);
//        dataPoints1.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("name", "2 Sao");
//        map.put("y", (float)starModel.countTwo()/count);
//        dataPoints1.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("name", "3 Sao");
//        map.put("y",  (float)starModel.countThree()/count);
//        dataPoints1.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("name", "4 Sao");
//        map.put("y",  (float)starModel.countFour()/count);
//        dataPoints1.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("name", "5 Sao");
//        map.put("y", (float)starModel.countFive()/count);
//        dataPoints1.add(map);
//
//        list.add(dataPoints1);
//    }
    public static List<List<Map<Object, Object>>> getCanvasjsDataList() {
        StarModel starModel = new StarModel();
        Map<Object, Object> map = null;
        List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
        List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
        float count = (float) starModel.totalCount() / 100;
        map = new HashMap<Object, Object>();
        map.put("name", "1 Sao");
        map.put("y", (float) starModel.countOne() / count);
        dataPoints1.add(map);
        map = new HashMap<Object, Object>();
        map.put("name", "2 Sao");
        map.put("y", (float) starModel.countTwo() / count);
        dataPoints1.add(map);
        map = new HashMap<Object, Object>();
        map.put("name", "3 Sao");
        map.put("y", (float) starModel.countThree() / count);
        dataPoints1.add(map);
        map = new HashMap<Object, Object>();
        map.put("name", "4 Sao");
        map.put("y", (float) starModel.countFour() / count);
        dataPoints1.add(map);
        map = new HashMap<Object, Object>();
        map.put("name", "5 Sao");
        map.put("y", (float) starModel.countFive() / count);
        dataPoints1.add(map);

        list.add(dataPoints1);
        return list;
    }
}

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
import ogani.entityMore.ProductGroup;
import ogani.model.OrderDetailModel;

/**
 *
 * @author Bang-GoD
 */
public class ChartAdmin {

//    static List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
//    static List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
//    private static OrderDetailModel orderDetailModel = new OrderDetailModel();
//
//    static Map<Object, Object> map = null;
//
//    static {
//        List<ProductGroup> listOrder = orderDetailModel.top5Product();
//        for (ProductGroup pg : listOrder) {
//            map = new HashMap<Object, Object>();
//              map.put("label", pg.getProduct().getProdName());
//            map.put("y",  pg.getTotalAmount());
//            dataPoints1.add(map);
//        }
//        list.add(dataPoints1);
//    }
    public static List<List<Map<Object, Object>>> getCanvasjsDataList() {
        List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
        List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
        OrderDetailModel orderDetailModel = new OrderDetailModel();
        Map<Object, Object> map = null;
        {
            List<ProductGroup> listOrder = orderDetailModel.top5Product();
            for (ProductGroup pg : listOrder) {
                map = new HashMap<Object, Object>();
                map.put("label", pg.getProduct().getProdName());
                map.put("y", pg.getTotalAmount());
                dataPoints1.add(map);
            }
            list.add(dataPoints1);
        }
        return list;
    }
}

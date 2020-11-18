/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletResponse;
import ogani.entityMore.ProductGroup;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;

/**
 *
 * @author Bang-GoD
 */
public class Excel {

    public static final int COLUMN_INDEX_ID = 0;
    public static final int COLUMN_INDEX_TITLE = 1;
    public static final int COLUMN_INDEX_PRICE = 2;
    public static final int COLUMN_INDEX_QUANTITY = 3;
    public static final int COLUMN_INDEX_TOTAL = 4;
    private static CellStyle cellStyleFormatNumber = null;

    private static HSSFCellStyle createStyleForTitle(HSSFWorkbook workbook) {
        HSSFFont font = workbook.createFont();
        font.setBold(true);
        HSSFCellStyle style = workbook.createCellStyle();
        style.setFont(font);
        return style;
    }

    public void writeExcel(List<ProductGroup> list, Integer month, Integer year, HttpServletResponse response) throws IOException {

        String fileName = "thongkethang" + month + "-" + year + ".xls";

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("Product");

        sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 5));

        int rownum = 3;
        Cell cell;
        Row row;
        //Tiêu đề
        Row rowTd = sheet.createRow(1);
        Cell cellTd = rowTd.createCell(1);
        cellTd.setCellValue("Thống Kê Sản Phẩm Bán Ra Tháng "+month+" Năm "+year+"");

        HSSFCellStyle style = createStyleForTitle(workbook);
        row = sheet.createRow(rownum);
        cell = row.createCell(1, CellType.STRING);
        cell.setCellValue("Tên Sản Phẩm");
        cell.setCellStyle(style);
        cell = row.createCell(2, CellType.STRING);
        cell.setCellValue("Đơn Giá");
        cell.setCellStyle(style);
        cell = row.createCell(3, CellType.STRING);
        cell.setCellValue("Số Lượng");
        cell.setCellStyle(style);
        cell = row.createCell(4, CellType.STRING);
        cell.setCellValue("Giá Bán");
        cell.setCellStyle(style);
        cell = row.createCell(5, CellType.STRING);
        cell.setCellValue("Thành Tiền");
        cell.setCellStyle(style);
        double tongtien = 0;
        for (ProductGroup pg : list) {
            tongtien += pg.getTotalAmount();
            rownum++;
            row = sheet.createRow(rownum);
            // (B)
            cell = row.createCell(1, CellType.STRING);
            cell.setCellValue(pg.getProduct().getProdName());
            //(C)
            cell = row.createCell(2, CellType.STRING);
            cell.setCellValue(pg.getProduct().getPrice());
            // (D)
            cell = row.createCell(3, CellType.STRING);
            cell.setCellValue(pg.getQuantity());
            // (E)Giá Bán= Giá gốc- Giá gốc*giảm giá chia 100
            cell = row.createCell(4, CellType.STRING);
            cell.setCellValue(pg.getProduct().getPrice() - (pg.getProduct().getPrice() * pg.getAvgStar() / 100));
            //(F)
            cell = row.createCell(5, CellType.STRING);
            cell.setCellValue(pg.getTotalAmount());
        }
        //Tổng Tiền Kiếm Đc
         sheet.addMergedRegion(new CellRangeAddress(rownum+2, rownum+2, 1, 5));
        Row rowTong = sheet.createRow(rownum+2);
        Cell cellTong = rowTong.createCell(1);
        cellTong.setCellValue("Tổng Tiền: "+tongtien+" VND");
        
        
        FileOutputStream fileOut = new FileOutputStream(fileName);
        workbook.write(fileOut);
        fileOut.close();
        File fileToDownload = new File(fileName);
        InputStream in = new FileInputStream(fileToDownload);
        // Gets MIME type of the file
        String mimeType = new MimetypesFileTypeMap().getContentType(fileName);
        if (mimeType == null) {
            // Set to binary type if MIME mapping not found
            mimeType = "application/octet-stream";
        }
        System.out.println("MIME type: " + mimeType);
        // Modifies response
        response.setContentType(mimeType);
        response.setContentLength((int) fileToDownload.length());
        // Forces download
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"", fileToDownload.getName());
        response.setHeader(headerKey, headerValue);
        // obtains response's output stream
        OutputStream outStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        while ((bytesRead = in.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }
        in.close();
        outStream.close();
    }
}

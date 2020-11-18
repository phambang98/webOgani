/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.upfile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Bang-GoD
 */
public class UpFileMutil {
     private static final String URI_FOLDER = "/jsp";
    private static final String URI_DB = "../jsp/user/img/product-details/";
    private static final String URI_WRITE = "\\web\\jsp\\user\\img\\product-details\\";

    public String saveImageToFolder(HttpServletRequest request, MultipartFile multi) {
        String uriDBSave = null;
        try {
            //Lay duong dan tuyet doi da build cua thu muc images chua cac anh cua project
            String path = request.getRealPath(URI_FOLDER);
            //Cat lay duong dan goc cua project
            path = path.substring(0, path.indexOf("\\build"));
            //Tro duong dan vao thu muc images
            path += URI_WRITE;
            //Kiem tra thu muc images da ton tai chua, neu chua tao thu muc
            Path pathCreate = Paths.get(path);
            if (!Files.exists(pathCreate)) {
                Files.createDirectories(pathCreate);
            }
            //Save images vao thu muc URI_WRITE
            byte[] byteImage = multi.getBytes();
            Path pathImageSave = Paths.get(path + multi.getOriginalFilename());
            Files.write(pathImageSave, byteImage, StandardOpenOption.CREATE);
            //Duong dan image luu o trong db
            uriDBSave = URI_DB + multi.getOriginalFilename();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return uriDBSave;
    }
    
}

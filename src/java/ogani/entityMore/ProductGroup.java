/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.entityMore;

import ogani.entity.Product;

/**
 *
 * @author Bang-GoD
 */
public class ProductGroup {
 
    private Long quantity;
    private Double totalAmount;
    private Product product;
    private Double avgStar;
    private Long countUser;

    
    //ko dùng
    public ProductGroup(Long quantity, Double totalAmount, Long countUser, Product product, Double avgStar) {
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.countUser = countUser;
        this.product = product;
        this.avgStar = avgStar;
    }
    
    //Tính số tiền kiếm đc và số lượng đã bán
    public ProductGroup(Long quantity, Double totalAmount, Product product) {
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.product = product;
    }

    //Tính số người đánh giá và trung bình rate
    public ProductGroup(Product product, Double avgStar, Long countUser) {
        this.product = product;
        this.avgStar = avgStar;
        this.countUser = countUser;
    }
    //Top sản phẩm
    public ProductGroup(Double totalAmount, Product product) {
        this.totalAmount = totalAmount;
        this.product = product;
    }
    //Test
    public ProductGroup(Long quantity, Product product) {
        this.quantity = quantity;
        this.product = product;
    }
    
    //Tính chi tiết xem sản phẩm bán với giá bao nhiêu, giảm giá bao nhiêu

    public ProductGroup(Long quantity, Double totalAmount, Product product, Double avgStar) {
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.product = product;
        this.avgStar = avgStar;
    }
    
    
    
    

    public Long getCountUser() {
        return countUser;
    }

    public void setCountUser(Long countUser) {
        this.countUser = countUser;
    }

    

   

    public Double getAvgStar() {
        return avgStar;
    }

    public void setAvgStar(Double avgStar) {
        this.avgStar = avgStar;
    }
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
  
    public ProductGroup() {
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "ProductGroup{" + "quantity=" + quantity + ", totalAmount=" + totalAmount + ", product=" + product.getProdName() + ", avgStar=" + avgStar + ", countUser=" + countUser + '}';
    }
    


}

    

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.entityMore;

import ogani.entity.Users;

/**
 *
 * @author Bang-GoD
 */
public class UserGroup {
    private Double totalAmount;
    private Users users;
    private Long countStar,countComment,countBuy;

    public UserGroup(Users users, Long countStar, Long countComment, Long countBuy) {
        this.users = users;
        this.countStar = countStar;
        this.countComment = countComment;
        this.countBuy = countBuy;
    }

    public UserGroup(Double totalAmount, Users users) {
        this.totalAmount = totalAmount;
        this.users = users;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public Long getCountStar() {
        return countStar;
    }

    public void setCountStar(Long countStar) {
        this.countStar = countStar;
    }

    public Long getCountComment() {
        return countComment;
    }

    public void setCountComment(Long countComment) {
        this.countComment = countComment;
    }

    public Long getCountBuy() {
        return countBuy;
    }

    public void setCountBuy(Long countBuy) {
        this.countBuy = countBuy;
    }

    

    @Override
    public String toString() {
        return "UserGroup{" + "totalAmount=" + totalAmount + ", users=" + users + ", countStar=" + countStar + ", countComment=" + countComment + ", countBuy=" + countBuy + '}';
    }
    

   
    
}

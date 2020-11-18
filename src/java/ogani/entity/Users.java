package ogani.entity;
// Generated Oct 31, 2020 11:45:12 AM by Hibernate Tools 4.3.1


import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Users generated by hbm2java
 */
@Entity
@Table(name="Users"
    ,schema="dbo"
    ,catalog="WebOgani"
)
public class Users  implements java.io.Serializable {


     private int userId;
     private String userName;
     private String passWords;
     private String userEmail;
     private boolean userStatus;
     private String phone;
     private String userAddress;
     private String userImage;
     private boolean isAdmin;
     private Set<Comment> comments = new HashSet<Comment>(0);
     private Set<Orders> orderses = new HashSet<Orders>(0);
     private Set<Star> stars = new HashSet<Star>(0);

    public Users() {
    }

	
    public Users(int userId, String userName, String passWords, String userEmail, boolean userStatus, String phone, String userAddress, String userImage, boolean isAdmin) {
        this.userId = userId;
        this.userName = userName;
        this.passWords = passWords;
        this.userEmail = userEmail;
        this.userStatus = userStatus;
        this.phone = phone;
        this.userAddress = userAddress;
        this.userImage = userImage;
        this.isAdmin = isAdmin;
    }
    public Users(int userId, String userName, String passWords, String userEmail, boolean userStatus, String phone, String userAddress, String userImage, boolean isAdmin, Set<Comment> comments, Set<Orders> orderses, Set<Star> stars) {
       this.userId = userId;
       this.userName = userName;
       this.passWords = passWords;
       this.userEmail = userEmail;
       this.userStatus = userStatus;
       this.phone = phone;
       this.userAddress = userAddress;
       this.userImage = userImage;
       this.isAdmin = isAdmin;
       this.comments = comments;
       this.orderses = orderses;
       this.stars = stars;
    }
   
     @Id 

    
    @Column(name="UserId", unique=true, nullable=false)
    public int getUserId() {
        return this.userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }

    
    @Column(name="UserName", nullable=false)
    public String getUserName() {
        return this.userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }

    
    @Column(name="PassWords", nullable=false)
    public String getPassWords() {
        return this.passWords;
    }
    
    public void setPassWords(String passWords) {
        this.passWords = passWords;
    }

    
    @Column(name="UserEmail", nullable=false)
    public String getUserEmail() {
        return this.userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    
    @Column(name="UserStatus", nullable=false)
    public boolean isUserStatus() {
        return this.userStatus;
    }
    
    public void setUserStatus(boolean userStatus) {
        this.userStatus = userStatus;
    }

    
    @Column(name="Phone", nullable=false)
    public String getPhone() {
        return this.phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }

    
    @Column(name="UserAddress", nullable=false)
    public String getUserAddress() {
        return this.userAddress;
    }
    
    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    
    @Column(name="UserImage", nullable=false)
    public String getUserImage() {
        return this.userImage;
    }
    
    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    
    @Column(name="IsAdmin", nullable=false)
    public boolean isIsAdmin() {
        return this.isAdmin;
    }
    
    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="users")
    public Set<Comment> getComments() {
        return this.comments;
    }
    
    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="users")
    public Set<Orders> getOrderses() {
        return this.orderses;
    }
    
    public void setOrderses(Set<Orders> orderses) {
        this.orderses = orderses;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="users")
    public Set<Star> getStars() {
        return this.stars;
    }
    
    public void setStars(Set<Star> stars) {
        this.stars = stars;
    }




}


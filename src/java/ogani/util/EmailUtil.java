/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.util;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    private static final String host = "smtp.gmail.com";
    private static final String port = "587";
    private static final String userName = "bangbang15071998@gmail.com";
    private static final String password = "Khongbiet12";

    public static void sendEmail(String recipient, String subject, String message)
            throws AddressException, MessagingException {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        Authenticator auth = new Authenticator() {
            @Override
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
        MimeMessage msg = new MimeMessage(session);
        msg.setHeader("Content-Type", "text/plain; charset=UTF-8");
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = {new InternetAddress(recipient)};
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject, "utf-8");
        msg.setSentDate(new Date());
        msg.setContent("<h1>Cảm Ơn Bạn Đã Vào Website.Nội Dung Bạn Muốn Truyền Tải:"+message+"</h1>",
                "text/html;charset=UTF-8");
        Transport.send(msg);
    }
}

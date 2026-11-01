package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {

    // Hàm gửi OTP quên mật khẩu (đã có sẵn của bạn)
    public static void sendOtp(String recipientEmail, String otpCode) {
        final String senderEmail = "phatphgtv00198@gmail.com";
        final String senderPassword = "trfq ozyf kldk iilf";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Mã xác thực quên mật khẩu - Cửa Hàng Điện Máy");
            message.setText("Xin chào,\n\nMã OTP xác thực đổi mật khẩu của bạn là: " + otpCode + "\nMã này có hiệu lực trong 2 phút.\n\nTrân trọng!");
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    // === BẠN HÃY THÊM HÀM NÀY VÀO DƯỚI ĐÂY ĐỂ DÙNG CHO ĐĂNG KÝ TÀI KHOẢN ===
    public static void sendRegistrationEmail(String recipientEmail, String customerName) {
        final String senderEmail = "phatphgtv00198@gmail.com";
        final String senderPassword = "trfq ozyf kldk iilf";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Đăng ký tài khoản thành công - Cửa Hàng Điện Máy");

            // Nội dung email thông báo đăng ký thành công
            String htmlContent = "<h3>Xin chào " + customerName + ",</h3>"
                    + "<p>Chúc mừng bạn đã đăng ký tài khoản thành công tại <b>Cửa Hàng Điện Máy</b>!</p>"
                    + "<p>Cảm ơn bạn đã tin tưởng và đồng hành cùng chúng tôi.</p>"
                    + "<br><p>Trân trọng,<br><b>Ban quản trị website</b></p>";

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
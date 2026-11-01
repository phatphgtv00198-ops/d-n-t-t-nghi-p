package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {
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
}
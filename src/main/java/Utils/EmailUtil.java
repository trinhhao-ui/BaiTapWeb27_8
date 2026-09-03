package Utils;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;
import java.util.Random;

/**
 * EmailUtil — Gửi OTP qua Gmail SMTP
 */
public class EmailUtil {

    // ── CẤU HÌNH GMAIL ───────────────────────────────────────
    // TODO: Thay bằng Gmail và App Password của bạn
    private static final String SENDER_EMAIL    = "trinhphuhao2108@gmail.com";
    private static final String SENDER_PASSWORD = "tozu enwd rsyq xiga";   // App Password (16 ký tự)
    // ─────────────────────────────────────────────────────────

    /**
     * Tạo mã OTP ngẫu nhiên 6 chữ số
     */
    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // 100000 - 999999
        return String.valueOf(otp);
    }

    /**
     * Gửi OTP kích hoạt tài khoản
     */
    public static void sendActivationOtp(String toEmail, String otpCode) throws MessagingException {
        String subject = "[BaiTapWeb] Kích hoạt tài khoản của bạn";
        String body = buildOtpEmail(
            "Kích hoạt tài khoản",
            "Cảm ơn bạn đã đăng ký! Vui lòng dùng mã OTP dưới đây để kích hoạt tài khoản:",
            otpCode,
            "Mã OTP có hiệu lực trong <strong>5 phút</strong>."
        );
        sendEmail(toEmail, subject, body);
    }

    /**
     * Gửi OTP reset mật khẩu
     */
    public static void sendResetPasswordOtp(String toEmail, String otpCode) throws MessagingException {
        String subject = "[BaiTapWeb] Đặt lại mật khẩu";
        String body = buildOtpEmail(
            "Đặt lại mật khẩu",
            "Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Dùng mã OTP sau:",
            otpCode,
            "Mã OTP có hiệu lực trong <strong>5 phút</strong>. Nếu bạn không yêu cầu, hãy bỏ qua email này."
        );
        sendEmail(toEmail, subject, body);
    }

    /**
     * Core: gửi email HTML qua Gmail SMTP
     */
    private static void sendEmail(String toEmail, String subject, String htmlBody)
            throws MessagingException {

        Properties props = new Properties();
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust",       "smtp.gmail.com");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        try {
            // InternetAddress(addr, personal, charset) ném UnsupportedEncodingException
            message.setFrom(new InternetAddress(SENDER_EMAIL, "BaiTapWeb", "UTF-8"));
        } catch (java.io.UnsupportedEncodingException e) {
            // fallback: dùng constructor không có charset
            message.setFrom(new InternetAddress(SENDER_EMAIL));
        }
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setContent(htmlBody, "text/html; charset=UTF-8");

        Transport.send(message);
    }

    /**
     * Build nội dung email HTML dạng OTP box
     */
    private static String buildOtpEmail(String title, String intro, String otpCode, String note) {
        return "<!DOCTYPE html><html><body style='font-family:Arial,sans-serif;background:#f4f4f4;margin:0;padding:20px'>"
             + "<div style='max-width:480px;margin:auto;background:#fff;border-radius:8px;padding:32px;box-shadow:0 2px 8px rgba(0,0,0,.1)'>"
             + "<h2 style='color:#2c3e50;margin-top:0'>" + title + "</h2>"
             + "<p style='color:#555'>" + intro + "</p>"
             + "<div style='text-align:center;margin:24px 0'>"
             + "<span style='font-size:36px;font-weight:bold;letter-spacing:8px;"
             + "color:#fff;background:#3498db;padding:12px 28px;border-radius:6px'>"
             + otpCode + "</span></div>"
             + "<p style='color:#888;font-size:13px'>" + note + "</p>"
             + "<hr style='border:none;border-top:1px solid #eee;margin:20px 0'>"
             + "<p style='color:#aaa;font-size:12px;text-align:center'>BaiTapWeb &copy; 2026</p>"
             + "</div></body></html>";
    }
}

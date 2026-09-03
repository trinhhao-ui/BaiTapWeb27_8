-- ================================================================
-- Script cập nhật bảng users để hỗ trợ OTP + kích hoạt tài khoản
-- Chạy script này trong SQL Server Management Studio (SSMS)
-- Database: ltws3
-- ================================================================

USE ltws3;
GO

-- 1. Thêm cột status: 0 = chưa kích hoạt, 1 = đã kích hoạt
ALTER TABLE users ADD status INT NOT NULL DEFAULT 0;
GO

-- 2. Thêm cột otp: mã OTP 6 số (lưu dạng string)
ALTER TABLE users ADD otp NVARCHAR(10) NULL;
GO

-- 3. Thêm cột otp_expiry: thời điểm OTP hết hạn
ALTER TABLE users ADD otp_expiry DATETIME NULL;
GO

-- 4. Kích hoạt tất cả tài khoản cũ (nếu đã có dữ liệu)
UPDATE users SET status = 1 WHERE status = 0;
GO

-- Kiểm tra kết quả
SELECT id, username, email, status, otp, otp_expiry FROM users;
GO

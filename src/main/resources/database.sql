-- ================================================================
-- SCRIPT KHỞI TẠO DATABASE ĐẦY ĐỦ
-- Chạy trong SQL Server Management Studio (SSMS)
-- ================================================================

USE master;
GO

-- Xóa DB cũ nếu tồn tại (bỏ comment nếu muốn reset hoàn toàn)
-- ALTER DATABASE ltws3 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- DROP DATABASE IF EXISTS ltws3;
-- GO

CREATE DATABASE ltws3;
GO

USE ltws3;
GO

-- ── Bảng Category ────────────────────────────────────────────────
CREATE TABLE Category (
    cate_id   INT PRIMARY KEY IDENTITY(1,1),
    cate_name NVARCHAR(255) NOT NULL,
    icons     NVARCHAR(255) NULL
);
GO

-- ── Bảng users ───────────────────────────────────────────────────
CREATE TABLE users (
    id          INT PRIMARY KEY IDENTITY(1,1),
    email       NVARCHAR(100),
    username    NVARCHAR(50)  NOT NULL UNIQUE,
    fullname    NVARCHAR(100),
    password    NVARCHAR(100) NOT NULL,
    avatar      NVARCHAR(255),
    roleid      INT NOT NULL DEFAULT 5,
    phone       NVARCHAR(20),
    createdDate DATE,
    status      INT NOT NULL DEFAULT 1,
    otp         NVARCHAR(10)  NULL,
    otp_expiry  DATETIME      NULL
);
GO

-- ── Bảng products (quan hệ N-1 với Category) ─────────────────────
CREATE TABLE products (
    product_id    INT           PRIMARY KEY IDENTITY(1,1),
    product_name  NVARCHAR(255) NOT NULL,
    description   NVARCHAR(MAX) NULL,
    price         DECIMAL(18,2) NOT NULL DEFAULT 0,
    quantity      INT           NOT NULL DEFAULT 0,
    image         NVARCHAR(255) NULL,
    status        INT           NOT NULL DEFAULT 1,
    created_date  DATETIME      NOT NULL DEFAULT GETDATE(),
    cate_id       INT           NOT NULL,
    CONSTRAINT FK_products_category
        FOREIGN KEY (cate_id) REFERENCES Category(cate_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- ── Tài khoản mẫu ────────────────────────────────────────────────
-- roleid: 1 = Admin, 5 = User thường
-- QUAN TRỌNG: password dưới đây là plain text (chưa hash)
--             phải >= 6 ký tự để qua validation
INSERT INTO users (email, username, fullname, password, avatar, roleid, phone, createdDate, status)
VALUES
(N'admin@gmail.com', N'admin', N'Quản trị viên', N'admin123', NULL, 1, N'0123456789', GETDATE(), 1),
(N'user@gmail.com',  N'user',  N'Người dùng',    N'user123',  NULL, 5, N'0987654321', GETDATE(), 1);
GO

-- ── Danh mục mẫu ─────────────────────────────────────────────────
INSERT INTO Category (cate_name, icons) VALUES
(N'Áo Nam',   N'images/ao-nam.png'),
(N'Áo Nữ',   N'images/ao-nu.png'),
(N'Quần Nam', N'images/quan-nam.png'),
(N'Phụ Kiện', N'images/phu-kien.svg');
GO

-- ── Sản phẩm mẫu (15 sản phẩm) ───────────────────────────────────
INSERT INTO products (product_name, description, price, quantity, image, status, cate_id) VALUES
(N'Áo Polo Nam Trắng',   N'Áo polo nam chất liệu cotton cao cấp',     250000, 100, NULL, 1, 1),
(N'Áo Sơ Mi Nam Xanh',  N'Áo sơ mi nam công sở',                      320000,  50, NULL, 1, 1),
(N'Áo Thun Nam Basic',   N'Áo thun nam cotton 100% thoáng mát',        150000, 200, NULL, 1, 1),
(N'Áo Khoác Nam Bomber', N'Áo khoác bomber nam phong cách Hàn Quốc',   550000,  60, NULL, 1, 1),
(N'Áo Thun Nữ Hồng',    N'Áo thun nữ form rộng',                      180000, 200, NULL, 1, 2),
(N'Áo Len Nữ Cổ Lọ',    N'Áo len nữ giữ ấm, màu pastel',              280000, 150, NULL, 1, 2),
(N'Đầm Nữ Dáng Xòe',    N'Đầm xòe nữ phù hợp đi tiệc',               420000,  80, NULL, 1, 2),
(N'Áo Sơ Mi Nữ Trắng',  N'Áo sơ mi nữ công sở thanh lịch',            290000, 120, NULL, 1, 2),
(N'Quần Jean Nam',        N'Quần jean nam slim fit',                    450000,  80, NULL, 1, 3),
(N'Quần Short Nam',       N'Quần short nam thể thao thoải mái',         180000, 300, NULL, 1, 3),
(N'Quần Kaki Nam',        N'Quần kaki nam slim fit lịch sự',            380000,  90, NULL, 1, 3),
(N'Quần Jogger Nữ',       N'Quần jogger nữ năng động, co giãn tốt',    220000, 180, NULL, 1, 3),
(N'Thắt Lưng Da',         N'Thắt lưng da bò thật',                     150000, 120, NULL, 1, 4),
(N'Mũ Lưỡi Trai',         N'Mũ lưỡi trai unisex phong cách',           120000, 250, NULL, 1, 4),
(N'Túi Tote Canvas',      N'Túi tote vải canvas đựng đồ đi học',       180000, 200, NULL, 1, 4);
GO

-- ── Kiểm tra ─────────────────────────────────────────────────────
SELECT * FROM users;
SELECT * FROM Category;
SELECT p.product_id, p.product_name, p.price, c.cate_name
FROM products p JOIN Category c ON p.cate_id = c.cate_id;
GO

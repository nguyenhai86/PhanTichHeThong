﻿ --CREATE DATABASE QLHOCSINH
 --GO

USE QLHOCSINH
GO
CREATE TABLE HSChoNhapHoc
(
	Ma CHAR(10) PRIMARY KEY,
	Ten NVARCHAR(50) NOT NULL,
	CCCD CHAR(12) NOT NULL UNIQUE,
	DiaChi NVARCHAR(50),
	SoDienThoai CHAR(10) UNIQUE
)
CREATE TABLE DSTrungTuyen
(
	MaTS CHAR(10) PRIMARY KEY,
	TenTS NVARCHAR(50) NOT NULL,
	CCCD CHAR(12) NOT NULL UNIQUE,
	DiaChi NVARCHAR(MAX),
	NgaySinh DATE NOT NULL,
	GioiTinh BIT NOT NULL,
	SoDienThoai CHAR(10) UNIQUE
)
CREATE TABLE LoaiNhanVien
(
    MaLoai CHAR(10) PRIMARY KEY,
    TenLoai NVARCHAR(50),
)
CREATE TABLE NhanVien
(
    MaNV CHAR(10) PRIMARY KEY,
    TenNV NVARCHAR(50) NOT NULL,
    MaLoai CHAR(10) FOREIGN KEY REFERENCES dbo.LoaiNhanVien(MaLoai)
)
CREATE TABLE HOCSINH
(
    MaHS CHAR(10) PRIMARY KEY,
    TenHS NVARCHAR(50) NOT NULL,
    CCCD CHAR(12) NOT NULL UNIQUE,
	DiaChi NVARCHAR(MAX),
	NgaySinh DATE NOT NULL,
	GioiTinh BIT NOT NULL,
    SoDienThoai CHAR(10) UNIQUE,
)
CREATE TABLE PhieuBienNhanHS
(
	MaPhieu CHAR(10) PRIMARY KEY,
	NgayNhan DATETIME NOT NULL,
	MaHS CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HOCSINH(MaHS),
	MaNV CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.NhanVien(MaNV),
)
CREATE TABLE HoSo
(
	MaHoSo CHAR(10) PRIMARY KEY,
	TenHoSo NVARCHAR(50),
	SoLuongToiDa INT,
	GhiChu NVARCHAR(100),
)
CREATE TABLE CTPhieuBienNhanHS
(
	MaPhieuBN CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.PhieuBienNhanHS(MaPhieu),
	MaHoSo CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HoSo(MaHoSo),
	SoLuong INT NOT NULL,
	GhiChu NVARCHAR(50),
	PRIMARY KEY(MaPhieuBN,MaHoSo),
)
CREATE TABLE MonHoc
(
	MaMon CHAR(10) PRIMARY KEY,
	TenMon NVARCHAR(50) NOT NULL,
)
CREATE TABLE NamHoc
(
	MaNamHoc CHAR(10) PRIMARY KEY,
	TenNamHoc NVARCHAR(50),
)
CREATE TABLE Khoi
(
	MaKhoi CHAR(10) PRIMARY KEY,
	TenKhoi NVARCHAR(50) NOT NULL,
)
CREATE TABLE HocKy
(
	MaHocKy CHAR(10) PRIMARY KEY,
	TenHocKy NVARCHAR(50) NOT NULL,
)
CREATE TABLE HocPhi
(
	MaHocPhi CHAR(10) PRIMARY KEY,
	SoTien MONEY NOT NULL,
	MaKhoi CHAR(10) NOT NULL FOREIGN KEY REFERENCES Khoi(MaKhoi),
	MaNamHoc CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.NamHoc(MaNamHoc),
	HocKy CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HocKy(MaHocKy)
)

--Quan he ke thua voi nhanvIEN
CREATE TABLE GiaoVien
(
	MaNV CHAR(10) PRIMARY KEY FOREIGN KEY REFERENCES dbo.NhanVien(MaNV),
	MaMon CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.MonHoc(MaMon)
)
CREATE TABLE LopHoc
(
	MaLop CHAR(10) PRIMARY KEY,
	TenLop NVARCHAR(50) NOT NULL,
	Khoi CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.Khoi(MaKhoi),
	NamHoc CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.NamHoc(MaNamHoc),
	GiaoVienCN CHAR(10) FOREIGN KEY REFERENCES dbo.GiaoVien(MaNV)
)
CREATE TABLE HocSinh_LopHoc
(
	MaHS CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HOCSINH(MaHS),
	MaLop CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.LopHoc(MaLop),
	DiemHanhKiem INT NOT NULL DEFAULT 70,
	PRIMARY KEY(MaHS,MaLop)
)
CREATE TABLE LopHoc_MonHoc
(
	MaLop CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.LopHoc(MaLop),
	MaMon CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.MonHoc(MaMon),
	MaGV CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.GiaoVien(MaNV),
	PRIMARY KEY(MaLop,MaMon)
)
CREATE TABLE LoaiKiemTra
(
	MaLoai CHAR(10) PRIMARY KEY,
	TenLoai NVARCHAR(50) NOT NULL,
	HeSo FLOAT NOT NULL,
)
CREATE TABLE KetQua
(
	MaHS CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HOCSINH(MaHS),
	MaLoaiKT CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.LoaiKiemTra(MaLoai),
	MaHocKy CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HocKy(MaHocKy),
	MaLop CHAR(10) NOT NULL,
	MaMon CHAR(10) NOT NULL,
	FOREIGN KEY(MaLop,MaMon) REFERENCES dbo.LopHoc_MonHoc(MaLop,MaMon),
	Diem DECIMAL NOT NULL CHECK (Diem >= 0),

	PRIMARY KEY(MaHS,MaLoaiKT,MaLop,MaMon,MaHocKy)
)
CREATE TABLE HoaDon
(
	MaHD CHAR(10) NOT NULL PRIMARY KEY,
	MaNV CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.NhanVien(MaNV),
	MaHS CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HOCSINH(MaHS),
	MaHocPhi CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.NhanVien(MaNV),
	SoTien MONEY NOT NULL,
)
CREATE TABLE HanhKiem
(
	MaHanhKiem CHAR(10) PRIMARY KEY,
	TenHanhKiem NVARCHAR(100) NOT NULL,
	Diem INT DEFAULT 0 NOT NULL,
)
CREATE TABLE PhieuBienNhanBieuHien
(
	MaPhieu CHAR(10) NOT NULL PRIMARY KEY,
	MaHS CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HOCSINH(MaHS),
	MaGV CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.GiaoVien(MaNV),
	MaHanhKiem CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HanhKiem(MaHanhKiem),
	Diem INT NOT NULL,
	GhiChu NVARCHAR(50),

)
CREATE TABLE TaiKhoan
(
	TenTaiKhoan CHAR(20) PRIMARY KEY,
	MatKhau NVARCHAR(MAX) NOT NULL,
	MaNV CHAR(10) FOREIGN KEY REFERENCES dbo.NhanVien(MaNV)
)
CREATE TABLE GiayXacNhanNhapHoc
(
	MaHS CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.HOCSINH(MaHS) PRIMARY KEY,
	MaNV CHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.NhanVien(MaNV),
	NgayLap DATE DEFAULT GETDATE(),
)
SET DATEFORMAT DMY
GO
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS001', N'Đỗ Ngọc Hương An', '578654748137', N'100 Âu Cơ, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định','12/03/2008',0, '0911825967' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS002', N'Lê Mỹ An', '489986894711', N'232 Âu Cơ, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định','15/03/2008',0, '0911825969' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS003', N'Lê Trương Thúy An', '691641972616', N'243 Âu Cơ, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định','16/02/2008',0, '0911825971' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS004', N'Lư Tiến An', '353428587428', N'100 Lạc Long Quân, Phường Trần Quang Diệu, Thành phố Quy Nhơn, Tỉnh Bình Định','16/04/2008',1, '0911825973' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS005', N'Lưu Văn An', '485487646617', N'34 Hồ Đắc Mậu, Phường Bùi Thị Xuân, Thành phố Quy Nhơn, Tỉnh Bình Định','17/05/2008',1, '0911828888' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS006', N'Võ Ngọc Hoài An', '834428248254', N'33 Huỳnh Văn Nghĩa, Phường Bùi Thị Xuân, Thành phố Quy Nhơn, Tỉnh Bình Định','17/05/2008',0, '0911182597' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS007', N'Võ Thị Mỹ An', '251249414765', N'222 Âu Cơ, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định','7/9/2008',0, '0913182459' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS008', N'Đỗ Thị Hồng Thắm', '833001180848', N'76 Quang Trung, Phường Bùi Thị Xuân, Thành phố Quy Nhơn, Tỉnh Bình Định','19/9/2008',0, '0898662163' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS009', N'Lê Minh Khánh', '832001170023', N'198 Huỳnh Văn Nghĩa, Phường Bùi Thị Xuân, Thành phố Quy Nhơn, Tỉnh Bình Định','19/10/2008',1, '0707058253' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS010', N'Phạm Thanh Hùng', '833001181729', N'77 Quang Trung, Phường Bùi Thị Xuân, Thành phố Quy Nhơn, Tỉnh Bình Định','19/9/2008',1, '0934158469' )
INSERT INTO dbo.DSTrungTuyen ( MaTS, TenTS, CCCD, DiaChi, NgaySinh, GioiTinh, SoDienThoai ) VALUES ( 'TS011', N'Nguyễn Tấn Đạt', '832001160650', N'432 Lạc Long Quân, Phường Trần Quang Diệu, Thành phố Quy Nhơn, Tỉnh Bình Định','15/9/2008',1, '0835233637' )

INSERT INTO dbo.LoaiNhanVien( MaLoai, TenLoai )VALUES( 'LNV001', N'Tài chính' )
INSERT INTO dbo.LoaiNhanVien( MaLoai, TenLoai )VALUES( 'LNV002', N'Giáo vụ' )
INSERT INTO dbo.LoaiNhanVien( MaLoai, TenLoai )VALUES( 'LNV003', N'Giáo viên' )

INSERT INTO dbo.NhanVien( MaNV, TenNV, MaLoai )VALUES( 'NV001', N'Nguyễn Văn Tài', 'LNV001' )
INSERT INTO dbo.NhanVien( MaNV, TenNV, MaLoai )VALUES( 'NV002', N'Nguyễn Thị Minh Tuyết', 'LNV001' )
INSERT INTO dbo.NhanVien( MaNV, TenNV, MaLoai )VALUES( 'NV003', N'Huỳnh Văn Kiên', 'LNV003' )
INSERT INTO dbo.NhanVien( MaNV, TenNV, MaLoai )VALUES( 'NV004', N'Mai Kiến Văn', 'LNV003' )
INSERT INTO dbo.NhanVien( MaNV, TenNV, MaLoai )VALUES( 'NV005', N'Nguyễn Duy Hải', 'LNV002' )

INSERT INTO dbo.HoSo( MaHoSo, TenHoSo, SoLuongToiDa, GhiChu )VALUES( 'HS001', N'Học bạ cấp THCS (Bản chính)', 1, N'' )
INSERT INTO dbo.HoSo( MaHoSo, TenHoSo, SoLuongToiDa, GhiChu )VALUES( 'HS002', N'Bằng tốt nghiệp THCS (bản chính)', 1, N'' )
INSERT INTO dbo.HoSo( MaHoSo, TenHoSo, SoLuongToiDa, GhiChu )VALUES( 'HS003', N'Bằng tốt nghiệp THCS bản tạm thời', 1, N'' )
INSERT INTO dbo.HoSo( MaHoSo, TenHoSo, SoLuongToiDa, GhiChu )VALUES( 'HS004', N'Bản sao giấy khai sinh hợp lệ', 1, N'' )

INSERT INTO dbo.NamHoc( MaNamHoc, TenNamHoc )VALUES( 'NH21_22', N'2021-2022' )
INSERT INTO dbo.NamHoc( MaNamHoc, TenNamHoc )VALUES( 'NH22_23', N'2022-2023' )

INSERT INTO dbo.Khoi( MaKhoi, TenKhoi )VALUES( 'KH10', N'Khối 10' )
INSERT INTO dbo.Khoi( MaKhoi, TenKhoi )VALUES( 'KH11', N'Khối 11' )
INSERT INTO dbo.Khoi( MaKhoi, TenKhoi )VALUES( 'KH12', N'Khối 12' )

INSERT INTO dbo.HocKy( MaHocKy, TenHocKy )VALUES( 'HK1', N'Học kỳ 1' )
INSERT INTO dbo.HocKy( MaHocKy, TenHocKy )VALUES( 'HK2', N'Học kỳ 2' )

INSERT INTO dbo.HocPhi( MaHocPhi, SoTien, MaKhoi, MaNamHoc, HocKy )VALUES( 'HP001', 1000000, 'KH10', 'NH21_22', 'HK1' )
INSERT INTO dbo.HocPhi( MaHocPhi, SoTien, MaKhoi, MaNamHoc, HocKy )VALUES( 'HP002', 1500000, 'KH11', 'NH21_22', 'HK1' )
INSERT INTO dbo.HocPhi( MaHocPhi, SoTien, MaKhoi, MaNamHoc, HocKy )VALUES( 'HP003', 1320000, 'KH11', 'NH21_22', 'HK1' )

INSERT INTO dbo.MonHoc( MaMon, TenMon )VALUES( 'MH001', N'Toán' )
INSERT INTO dbo.MonHoc( MaMon, TenMon )VALUES( 'MH002', N'Vật lý' )
INSERT INTO dbo.MonHoc( MaMon, TenMon )VALUES( 'MH003', N'Hoá học' )
INSERT INTO dbo.MonHoc( MaMon, TenMon )VALUES( 'MH004', N'Tin học' )

INSERT INTO dbo.GiaoVien( MaNV, MaMon )VALUES( 'NV003', 'MH004' )
INSERT INTO dbo.GiaoVien( MaNV, MaMon )VALUES( 'NV004', 'MH001' )

INSERT INTO dbo.LopHoc( MaLop, TenLop, Khoi, NamHoc, GiaoVienCN )VALUES( 'LH001', N'Lớp 10A3', 'KH10', 'NH22_23', 'NV003' )
INSERT INTO dbo.LopHoc( MaLop, TenLop, Khoi, NamHoc, GiaoVienCN )VALUES( 'LH002', N'Lớp 11A2', 'KH11', 'NH21_22', 'NV004' )


INSERT INTO dbo.TaiKhoan( TenTaiKhoan, MatKhau, MaNV )VALUES( 'nguyenhai', N'nguyenhai', 'NV005' )

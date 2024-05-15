select name,open_mode from v$database;

create table KhachHang(
    MaKH varchar(2) not null,
    TenKH varchar2(100),
    NgaySinh date,
    GioiTinh char(1) default 0,
    DiaChi varchar2(200),
    CONSTRAINT KH_PK primary key (MaKH)
);

INSERT INTO KhachHang (MaKH, TenKH, NgaySinh, GioiTinh, DiaChi) VALUES 
('01', 'Nguyễn Văn A', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'M', '123 Đường ABC, Quận 1, TP.HCM');
 INSERT INTO KhachHang (MaKH, TenKH, NgaySinh, GioiTinh, DiaChi) VALUES 
 ('02', 'Trần Thị B', TO_DATE('1992-02-02', 'YYYY-MM-DD'), 'F', '456 Đường XYZ, Quận 2, TP.HCM');

select *from khachhang;

-- tạo một profile 'quanly' có thời gian sử dụng là 60 ngày, số lần thay đổi password (5 lần), 
--ko cho đăng nhập nếu sai pass 3 lần và bị khóa tài khoản trong 5 ngày

create profile "C##QUANLY" limit
cpu_per_session UNLIMITED
cpu_per_call UNLIMITED
connect_time 30
idle_time UNLIMITED
sessions_per_user UNLIMITED
logical_reads_per_session UNLIMITED
logical_reads_per_call UNLIMITED
private_sga UNLIMITED
COMPOSITE_LIMIT UNLIMITED
PASSWORD_LIFE_TIME 30
PASSWORD_GRACE_TIME 7
PASSWORD_REUSE_MAX 2
PASSWORD_REUSE_TIME 30
PASSWORD_VERIFY_FUNCTION null
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 5

-- gan profile cho ng dung cu the
ALTER USER username PROFILE QUANLY;

CREATE USER c##new_user155 IDENTIFIED BY "123";

--gán quyền cơ bản để kêt nối tới csdl
GRANT CONNECT TO c##new_user155;

--gán profile
ALTER USER c##new_user155 PROFILE C##QUANLY;

-- đổi profile chỉ cho tối đa 2 lần sai mật khẩu

alter profile "C##QUANLY" limit
sessions_per_user 5
password_life_time 60
password_grace_time 60
password_reuse_max 2
password_lock_time 100;

USE QLBV
EXEC sp_changedbowner 'sa', 'true'
GO

CREATE TABLE BENHNHAN
(
MaBN char(10) not null,
HoTen nvarchar (50),
NgaySinh date,
GioiTinh varchar(5),
NgayNV date,
VienPhi money,
MaKhoaKham char(10)

constraint pk_mabn primary key (MaBN)
)


CREATE TABLE KHOAKHAM
(
MaKhoa char(10) not null,
TenKhoa nvarchar(50),
SoBenhNhan int,
MaBenhVien char(10)

constraint pk_makhoa primary key (MaKhoa)
)


CREATE TABLE BENHVIEN
(
MaBV char(10) not null,
TenBV nvarchar(50)

constraint pk_mabv primary key (MaBV)
)


alter table BENHNHAN ADD CONSTRAINT FK_MKK FOREIGN KEY (MaKhoaKham) references KHOAKHAM(MaKhoa)
alter table KHOAKHAM ADD CONSTRAINT FK_MBV FOREIGN KEY (MaBenhVien) references BENHVIEN(MaBV)



insert into BENHNHAN VALUES ('BN01',N'Nguyen Van A', '1992-02-18', 'Nam', '2002-01-01',50000,'TMH')
insert into BENHNHAN VALUES ('BN02',N'Nguyen Van B', '1992-02-18', 'Nam', '2003-01-02',60000,'RHM')
insert into BENHNHAN VALUES ('BN03',N'Nguyen Thi C', '1992-02-18', 'Nu', '2004-01-03',70000,'TIM')
insert into BENHNHAN VALUES ('BN04',N'Nguyen Van D', '1992-02-18', 'Nam', '2005-01-04',80000,'TMH')
insert into BENHNHAN VALUES ('BN05',N'Nguyen Thi E', '1992-02-18', 'Nu', '2006-01-05',90000,'RHM')

insert into KHOAKHAM values ('TMH',N'Tai mui hong',2,'BV01')
insert into KHOAKHAM values ('RHM',N'Rang ham mat',2,'BV02')
insert into KHOAKHAM values ('TIM',N'Tim mach',1,'BV03')

insert into BENHVIEN values ('BV01', N' Nguyễn Tri Phương') 
insert into BENHVIEN values ('BV02', N' Nguyễn Trãi')
insert into BENHVIEN values ('BV03', N' Chợ Rẫy')


SELECT * FROM BENHVIEN
SELECT * FROM BENHNHAN
SELECT * FROM KHOAKHAM


-- Cau 2
go
create trigger trg_cau2
on BENHNHAN
after insert
as

begin
declare @soluong int
select @soluong = KHOAKHAM.SoBenhNhan
from KHOAKHAM, inserted
where KHOAKHAM.MaKhoa=inserted.MaKhoaKham

if @soluong >= 5 
begin
print 'So benh nhan da vuot 5'
rollback transaction
end
else
update KHOAKHAM
set SoBenhNhan = SoBenhNhan + 1
from inserted where KHOAKHAM.MaKhoa=inserted.MaKhoaKham
end




-- Cau 3
go
create trigger trg_cau3
on BENHNHAN
after delete
as

begin
declare @soluong int
select @soluong = KHOAKHAM.SoBenhNhan
from KHOAKHAM, deleted
where KHOAKHAM.MaKhoa=deleted.MaKhoaKham

if @soluong <= 3
begin
print 'So benh nhan da duoi 3'
rollback transaction
end
else
update KHOAKHAM
set SoBenhNhan = SoBenhNhan - 1
from deleted where KHOAKHAM.MaKhoa=deleted.MaKhoaKham
end



-- Cau 4
go
create trigger trg_cau4
on BENHNHAN
after update
as

begin
declare @soluong int
select @soluong = KHOAKHAM.SoBenhNhan
from KHOAKHAM, inserted
where KHOAKHAM.MaKhoa=inserted.MaKhoaKham

if @soluong > 0
begin
print 'So luong benh nhan da co, khong the cap nhat thong tin benh vien'
rollback transaction
end

end







insert into BENHNHAN VALUES ('BN06',N'Nguyen Van F', '1992-02-01', 'Nam', '2002-01-05',50000,'TMH')
insert into BENHNHAN VALUES ('BN07',N'Nguyen Van X', '1992-02-04', 'Nam', '2002-01-06',60000,'TMH')
insert into BENHNHAN VALUES ('BN08',N'Nguyen Van Y', '1992-02-06', 'Nam', '2002-01-07',90000,'TMH')
insert into BENHNHAN VALUES ('BN09',N'Nguyen Van Z', '1992-02-07', 'Nam', '2002-01-08',100000,'TMH')





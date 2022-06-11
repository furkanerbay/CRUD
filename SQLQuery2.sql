CREATE PROCEDURE CalisanlarGetir
AS
	Select * from Calisanlar


CREATE PROCEDURE CalisanEkle
@calisanAd varchar(10),
@calisanSoyad varchar(10),
@calisanSehirId int
AS
	insert into Calisanlar
	values(@calisanAd,@calisanSoyad,@calisanSehirId)

CREATE PROCEDURE CalisanSil
@num int
AS
	DELETE FROM Calisanlar
	WHERE ID=@num


CREATE PROCEDURE CalisanGuncelle
@num int,
@calisanAd varchar(10),
@calisanSoyad varchar(10),
@calisanSehirId int
AS
	UPDATE Calisanlar
	SET
	CalisanAd = @calisanAd,
	CalisanSoyad = @calisanSoyad,
	CalisanSehirID = @calisanSehirId
	WHERE ID = @num

CREATE PROCEDURE FirmaGetir
AS
	Select * from FIRMALAR


CREATE PROCEDURE FirmaEkle
@firmaAdi varchar(10)
AS
	insert into FIRMALAR
	values(@firmaAdi)

CREATE PROCEDURE FirmaSil
@num int
AS
	Delete from FIRMALAR
	WHERE ID = @num


CREATE PROCEDURE FirmaGuncelle
@num int,
@firmaAdi varchar(10)
AS
	UPDATE FIRMALAR
	SET
	FirmaAdi = @firmaAdi
	WHERE ID = @num


CREATE PROCEDURE IlEkle
@ilAdi varchar(10)
AS
	INSERT INTO Iller
	values(@ilAdi)

CREATE PROCEDURE IlGetir
AS
Select * from Iller

CREATE PROCEDURE IlSil
@num int
AS
DELETE FROM ILLER
WHERE ID = @num

CREATE PROCEDURE IlGuncelle
@num int,
@ilAd varchar(10)
AS
UPDATE Iller
SET IlAdi = @ilAd
WHERE ID = @num

CREATE PROCEDURE KargoGetir
as
SELECT * FROM KARGOLAR


CREATE PROCEDURE SaticiHepsi
AS
Select * FROM SATICILAR


CREATE PROCEDURE SaticiEkle
@saticiAdi varchar(10),
@saticiSoyadi varchar(10),
@saticiSehirId int
AS
insert into SATICILAR
values(@saticiAdi,@saticiSoyadi,@saticiSehirId)


CREATE PROCEDURE MusteriHepsi
AS
SELECT * FROM Musteriler


CREATE PROCEDURE MusteriEkle
@musteriAdi varchar(10),
@musteriSoyadi varchar(10),
@musteriSehirId int
AS
insert into Musteriler
values(@musteriAdi,@musteriSoyadi,@musteriSehirId)


CREATE PROCEDURE MusteriSil
@num int
AS
DELETE FROM Musteriler
WHERE ID = @num


CREATE PROCEDURE MusteriGuncelle
@num int,
@musteriAdi varchar(10),
@musteriSoyadi varchar(10),
@yasadigiIlId int
AS
UPDATE Musteriler
SET MusteriAdi = @musteriAdi,MusteriSoyadi=@musteriSoyadi,YasadigiIlId=@yasadigiIlId
WHERE ID=@num
CREATE DATABASE Turkiye_Kargo_Takip;

use Turkiye_Kargo_Takip;



CREATE TABLE Iller
(
	ID int not null IDENTITY(1,1),
	IlAdi varchar(15) not null,
	CONSTRAINT PK_Iller PRIMARY KEY (ID)
)

CREATE TABLE Calisanlar
(
	ID int not null IDENTITY(1,1),
	CalisanAd varchar(15) not null,
	CalisanSoyad varchar(15) not null,
	CalisanSehirID int not null,
	CONSTRAINT PK_Calisanlar PRIMARY KEY (ID),
	CONSTRAINT FK_Calisanlar_Iller FOREIGN KEY(CalisanSehirID) REFERENCES ILLER(ID)
)

CREATE TABLE SATICILAR
(
	ID int not null IDENTITY(1,1),
	SaticiAdi varchar(25) not null,
	SaticiSoyadi varchar(25) not null,
	SaticiSehirID int not null,
	CONSTRAINT PK_Saticilar PRIMARY KEY(ID),
	CONSTRAINT FK_Saticilar_Iller FOREIGN KEY(SaticiSehirID) REFERENCES ILLER(ID)
)

CREATE TABLE Musteriler
(
	ID int not null IDENTITY(1,1),
	MusteriAdi varchar(15) not null,
	MusteriSoyadi varchar(15) not null,
	YasadigiIlId int not null,
	CONSTRAINT PK_Musteriler PRIMARY KEY (ID),
	CONSTRAINT FK_Musteriler_Iller FOREIGN KEY (YasadigiIlId) REFERENCES Iller(ID)
)

CREATE TABLE Kategoriler
(
	ID int not null IDENTITY(1,1),
	KategoriAdi varchar(20) not null
	CONSTRAINT PK_Kategoriler PRIMARY KEY (ID)
)

CREATE TABLE Urunler
(
	ID int not null IDENTITY(1,1),
	UrunAdi varchar(30) not null,
	KategoriID int not null,
	Fiyat int not null,
	UrunDetay varchar(250) not null,
	CONSTRAINT PK_Urunler PRIMARY KEY (ID),
	CONSTRAINT FK_Urunler_Kategoriler FOREIGN KEY (KategoriID) REFERENCES Kategoriler(ID)
)

CREATE TABLE FIRMALAR
(
	ID int not null IDENTITY(1,1),
	FirmaAdi varchar(20) not null,
	CONSTRAINT PK_Firmalar PRIMARY KEY(ID)
)

CREATE TABLE KARGOLAR
(
	ID int not null IDENTITY(1,1),
	FirmaID int not null,
	UrunID int not null,
	AlinanIlId int not null,
	GonderilenIlId int not null,
	GondericiID int not null,
	AliciID int not null,
	KargoyuAlanCalisanID int not null,
	KargoDetay varchar(250) not null,
	CONSTRAINT FK_Kargolar_Firmalar FOREIGN KEY(FirmaID) REFERENCES FIRMALAR(ID),
	CONSTRAINT FK_Kargolar_Urunler FOREIGN KEY(UrunID) REFERENCES URUNLER(ID),
	CONSTRAINT FK_Kargolar_Iller FOREIGN KEY(AlinanIlId) REFERENCES ILLER(ID),
	CONSTRAINT FK_Kargolar_Iller2 FOREIGN KEY(GonderilenIlId) REFERENCES ILLER(ID),
	CONSTRAINT FK_Kargolar_Saticilar FOREIGN KEY(GondericiId) REFERENCES SATICILAR(ID),
	CONSTRAINT FK_Kargolar_Musteriler FOREIGN KEY (AliciId) REFERENCES  MUSTERILER(ID),
	CONSTRAINT FK_Kargolar_Calisanlar FOREIGN KEY(KargoyuAlanCalisanID) REFERENCES Calisanlar(ID),
	CONSTRAINT PK_Kargolar PRIMARY KEY(ID)
)


CREATE PROCEDURE TumSaticilar
AS
	SELECT *
	FROM SATICILAR;


CREATE PROCEDURE SaticiEkle
@ad varchar(25),
@soyad varchar(25),
@sehirId int

AS
	insert into SATICILAR
	values(@ad,@soyad,@sehirId);


CREATE PROCEDURE  SaticiGuncelle
@num int,
@ad varchar(25),
@soyad varchar(25),
@sehirId int
AS
	update SATICILAR
	SET
	SaticiAdi = @ad,
	SaticiSoyadi = @soyad,
	SaticiSehirID = @sehirId
	where ID = @num;

exec SaticiGuncelle 2,'Ali','Veli',7

CREATE PROCEDURE SaticiSorgulama
@num int
AS
	SELECT *
	FROM SATICILAR
	WHERE ID=@num;


CREATE PROCEDURE SaticiSil
@num int
AS
	DELETE FROM SATICILAR
	WHERE ID = @num;

CREATE PROCEDURE SaticiBul
	@filtre varchar(32)
AS
	SELECT *
	FROM SATICILAR
	WHERE 
	ID LIKE CONCAT('%',@filtre,'%') OR
	SaticiAdi LIKE CONCAT('%',@filtre,'%') OR
	SaticiSoyadi LIKE CONCAT('%',@filtre,'%') OR
	SaticiSehirID LIKE CONCAT('%',@filtre,'%')
	

CREATE PROCEDURE SaticiSatislar
	@num int
AS
	SELECT *
	FROM KARGOLAR
	WHERE GondericiID = @num


CREATE PROCEDURE UrunlerinHepsi
AS
	SELECT *
	FROM URUNLER


CREATE PROCEDURE UrunEkle
@urunAdi varchar(20),
@kategoriId int,
@fiyat int,
@urunDetay varchar(250)

AS
	insert into Urunler
	values(@urunAdi,@kategoriId,@fiyat,@urunDetay);


CREATE PROCEDURE UrunGuncelle
@num int,
@urunAdi varchar(20),
@kategoriId int,
@fiyat int,
@urunDetay varchar(250)

AS
	UPDATE URUNLER
	SET 
	UrunAdi = @urunAdi,
	KategoriID = @kategoriId,
	Fiyat = @fiyat,
	UrunDetay=@urunDetay
	WHERE
	ID = @num



CREATE PROCEDURE UrunFiyatGuncelle
@num int,
@urunFiyat int
AS
	UPDATE URUNLER
	SET
	Fiyat = @urunFiyat
	WHERE
	ID = @num;


CREATE PROCEDURE UrunSil
@num int
AS
	DELETE FROM URUNLER
	WHERE ID = @num;


CREATE PROCEDURE UrunBul
@filtre varchar(32)
AS
		SELECT *
		FROM URUNLER
		WHERE
		ID      LIKE  CONCAT('%',@filtre,'%') OR
        UrunAdi       LIKE  CONCAT('%',@filtre,'%') OR
        KategoriID LIKE  CONCAT('%',@filtre,'%') OR
        Fiyat    LIKE  CONCAT('%',@filtre,'%') OR
        UrunDetay     LIKE  CONCAT('%',@filtre,'%');

CREATE PROCEDURE KargoUrunler
@num int
AS
	SELECT *
	FROM KARGOLAR
	WHERE UrunID = @num


CREATE PROCEDURE KargoEkle
@firmaId	int,
@urunId	int,
@alinanIlId	int,
@gonderilenIlId	int,
@gondericiId	int,
@aliciId	int,
@kargoyuAlanCalisanId int,
@kargoDetay varchar(250)
AS
	insert into KARGOLAR
	values(@firmaId,@urunId,@alinanIlId,@gonderilenIlId,@gondericiId,@aliciId,@kargoyuAlanCalisanId,@kargoDetay);


CREATE PROCEDURE  KargoSil
@num int
AS
	DELETE FROM KARGOLAR
	WHERE ID = @num;

CREATE PROCEDURE KargoGuncelle
	@num int,
	@firmaId int,
	@urunId int,
	@alinanIlId int,
	@gonderilenIlId int,
	@gondericiId int,
	@aliciId int,
	@kargoyuAlanCalisan int,
	@kargoDetay varchar(250)
AS
	UPDATE KARGOLAR
	SET
	FirmaID = @firmaId,
	UrunID = @urunId,
	AlinanIlId = @alinanIlId,
	GonderilenIlId = @gonderilenIlId,
	GondericiID = @gondericiId,
	AliciID = @aliciId,
	KargoyuAlanCalisanID = @kargoyuAlanCalisan,
	KargoDetay = @kargoDetay
	WHERE
	ID = @num;


CREATE PROCEDURE KargoDetay
AS
	SELECT k.ID,f.FirmaAdi,u.UrunAdi,i.IlAdi,i.IlAdi,s.SaticiAdi,m.MusteriAdi,c.CalisanAd,k.KargoDetay
	FROM KARGOLAR k
	inner join FIRMALAR f on k.FirmaID = f.ID
	inner join Urunler u on k.UrunID = u.ID
	inner join Iller i on k.AlinanIlId = i.ID and k.AlinanIlId = i.ID
	inner join SATICILAR s on k.GondericiID = s.ID
	inner join Musteriler m on k.AliciID = m.ID
	inner join Calisanlar c on k.KargoyuAlanCalisanID = c.ID;
	

CREATE PROCEDURE IndirimUrun
@num int,
@indirimFiyat int
AS
	Select ID,UrunAdi,KategoriId,Fiyat = Fiyat-@indirimFiyat,UrunDetay from Urunler
	where ID=@num


CREATE PROCEDURE UrunlerToplam
AS
	SELECT sum(Fiyat) as ToplamFiyat, AVG(Fiyat) as OrtalamaFiyat FROM Urunler

exec UrunlerToplam;

exec IndirimUrun 26,20

exec KargoDetay

exec KargoGuncelle 3,3,3,4,5,6,1,2,'Detay';

exec KargoSil 4

exec KargoEkle 1,1,1,2,1,2,1,'Samsung Televizyon PTT kargo ile yollandi';

exec KargoUrunler 2

exec UrunBul 'ap';


exec UrunSil 27;

exec UrunFiyatGuncelle 27,350

exec UrunGuncelle 27,'Alacakaranlik2',8,500,'Alacakaranlık Serisi Guncellendi'


exec UrunEkle 'Alacakaranlik',8,300,'Alacakaranlık serisi sizinle'

exec UrunlerinHepsi

exec SaticiSatislar 1

exec TumSaticilar;

exec SaticiEkle 'Furkan','Erbay',41

exec SaticiEkle 'Hakan','Tezer',66

exec SaticiSorgulama 2;

exec SaticiSil 10

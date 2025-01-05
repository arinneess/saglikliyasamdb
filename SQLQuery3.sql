--Prosedürü tanýmladýk ve parametreleri ekledik
CREATE PROCEDURE AddUserWithGoal 
    @Ad NVARCHAR(50),
    @Soyad NVARCHAR(50),
    @Eposta NVARCHAR(100),
    @Sifre NVARCHAR(100),
    @DogumTarihi DATE,
    @Boy DECIMAL(5,2),
    @Kilo DECIMAL(5,2),
    @Cinsiyet NVARCHAR(10),
    @VucutTipi NVARCHAR(50),
    @KanDegerleri NVARCHAR(MAX),
    @TansiyonSeviyesi NVARCHAR(50),
    @DigerSaglikNotlari NVARCHAR(MAX),
    @HedefTuru NVARCHAR(50)
AS
BEGIN
    -- Kullanýcý tablosuna yeni kullanýcýyý ekleme
    INSERT INTO Users (Ad, Soyad, Eposta, Sifre, DogumTarihi, Boy, Kilo, Cinsiyet, VucutTipi, KanDegerleri, TansiyonSeviyesi, DigerSaglikNotlari)
    VALUES (@Ad, @Soyad, @Eposta, @Sifre, @DogumTarihi, @Boy, @Kilo, @Cinsiyet, @VucutTipi, @KanDegerleri, @TansiyonSeviyesi, @DigerSaglikNotlari);
    
    DECLARE @KullaniciID INT;   --Yeni eklenen kullanýcýnýn IDsini saklamak için deðiþken tanýmlama
    SET @KullaniciID = SCOPE_IDENTITY(); --Scope komutu son eklenen satýrýn kimliðini döndürür 

    -- Yeni eklenen kullanýcý için hedef kaydý oluþturma ve hedefle ilgili bilgileri goals tablosuna ekleme
    INSERT INTO Goals (KullaniciID, HedefTuru, BaslangicTarihi, BeklenenBitisTarihi) 
    VALUES (@KullaniciID, @HedefTuru, GETDATE(), DATEADD(MONTH, 3, GETDATE())); 
END;
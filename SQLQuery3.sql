--Prosed�r� tan�mlad�k ve parametreleri ekledik
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
    -- Kullan�c� tablosuna yeni kullan�c�y� ekleme
    INSERT INTO Users (Ad, Soyad, Eposta, Sifre, DogumTarihi, Boy, Kilo, Cinsiyet, VucutTipi, KanDegerleri, TansiyonSeviyesi, DigerSaglikNotlari)
    VALUES (@Ad, @Soyad, @Eposta, @Sifre, @DogumTarihi, @Boy, @Kilo, @Cinsiyet, @VucutTipi, @KanDegerleri, @TansiyonSeviyesi, @DigerSaglikNotlari);
    
    DECLARE @KullaniciID INT;   --Yeni eklenen kullan�c�n�n IDsini saklamak i�in de�i�ken tan�mlama
    SET @KullaniciID = SCOPE_IDENTITY(); --Scope komutu son eklenen sat�r�n kimli�ini d�nd�r�r 

    -- Yeni eklenen kullan�c� i�in hedef kayd� olu�turma ve hedefle ilgili bilgileri goals tablosuna ekleme
    INSERT INTO Goals (KullaniciID, HedefTuru, BaslangicTarihi, BeklenenBitisTarihi) 
    VALUES (@KullaniciID, @HedefTuru, GETDATE(), DATEADD(MONTH, 3, GETDATE())); 
END;
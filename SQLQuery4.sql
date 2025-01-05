--Prosedür tanýmladýk ve parametreleri ekledik
CREATE PROCEDURE AddUserExercise
    @KullaniciID INT,
    @HareketID INT,
    @EgzersizSuresi INT,
    @Tarih DATE
AS
BEGIN
    -- Kullanýcý egzersiz kaydý ekleme
    INSERT INTO UserExercises (KullaniciID, HareketID, EgzersizSuresi, Tarih)
    VALUES (@KullaniciID, @HareketID, @EgzersizSuresi, @Tarih);

    -- Kullanýcýnýn ilerleme bilgilerini tutmak için deðiþken tanýmlama
    DECLARE @Kilo DECIMAL(5,2);
    DECLARE @VucutYagOrani DECIMAL(5,2);
    DECLARE @KasKutlesi DECIMAL(5,2);

    -- Kullanýcýnýn son ilerleme bilgilerini alýr
    SELECT TOP 1 @Kilo = Kilo, @VucutYagOrani = VucutYagOrani, @KasKutlesi = KasKutlesi  --top1 sadece en son kaydý getirir deðiþkenlere deðer atar
    FROM ProgressTracking
    WHERE KullaniciID = @KullaniciID
    ORDER BY Tarih DESC;

    -- Kullanýcýnýn kaydettiðimiz yeni ilerleme kaydýný ProgressTracking tablosuna ekler
    INSERT INTO ProgressTracking (KullaniciID, Kilo, VucutYagOrani, KasKutlesi, Tarih)
    VALUES (@KullaniciID, @Kilo, @VucutYagOrani, @KasKutlesi, @Tarih);
END;
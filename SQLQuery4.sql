--Prosed�r tan�mlad�k ve parametreleri ekledik
CREATE PROCEDURE AddUserExercise
    @KullaniciID INT,
    @HareketID INT,
    @EgzersizSuresi INT,
    @Tarih DATE
AS
BEGIN
    -- Kullan�c� egzersiz kayd� ekleme
    INSERT INTO UserExercises (KullaniciID, HareketID, EgzersizSuresi, Tarih)
    VALUES (@KullaniciID, @HareketID, @EgzersizSuresi, @Tarih);

    -- Kullan�c�n�n ilerleme bilgilerini tutmak i�in de�i�ken tan�mlama
    DECLARE @Kilo DECIMAL(5,2);
    DECLARE @VucutYagOrani DECIMAL(5,2);
    DECLARE @KasKutlesi DECIMAL(5,2);

    -- Kullan�c�n�n son ilerleme bilgilerini al�r
    SELECT TOP 1 @Kilo = Kilo, @VucutYagOrani = VucutYagOrani, @KasKutlesi = KasKutlesi  --top1 sadece en son kayd� getirir de�i�kenlere de�er atar
    FROM ProgressTracking
    WHERE KullaniciID = @KullaniciID
    ORDER BY Tarih DESC;

    -- Kullan�c�n�n kaydetti�imiz yeni ilerleme kayd�n� ProgressTracking tablosuna ekler
    INSERT INTO ProgressTracking (KullaniciID, Kilo, VucutYagOrani, KasKutlesi, Tarih)
    VALUES (@KullaniciID, @Kilo, @VucutYagOrani, @KasKutlesi, @Tarih);
END;
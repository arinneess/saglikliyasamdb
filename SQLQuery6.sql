--UserExercises tablosuna yeni bir egzersiz kaydý eklendiðinde çalýþacak ve ProgressTracking tablosundaki ilgili kullanýcý verilerini güncelleyecektir. 
--Ayrýca, eðer kullanýcý için ProgressTracking tablosunda bir veri yoksa, yeni bir kayýt ekleyecektir.
CREATE TRIGGER trg_UpdateProgressTracking
ON UserExercises
AFTER INSERT
AS
BEGIN
    DECLARE @KullaniciID INT, @EgzersizSuresi INT;

    -- Yeni eklenen egzersizin KullaniciID ve EgzersizSuresi'ni al
    SELECT @KullaniciID = KullaniciID, @EgzersizSuresi = EgzersizSuresi
    FROM INSERTED;

    -- Kullanýcýnýn ilerleme takibini güncelle
    UPDATE ProgressTracking
    SET Kilo = Kilo - (@EgzersizSuresi * 0.04), -- Egzersiz süresi kadar kilo kaybý
        VucutYagOrani = VucutYagOrani - (@EgzersizSuresi * 0.02), -- Vücut yað oranýnda bir azalma
        KasKutlesi = KasKutlesi + (@EgzersizSuresi * 0.01) -- Kas kütlesi artýþý
    WHERE KullaniciID = @KullaniciID;
    
    -- Eðer ProgressTracking tablosunda o kullanýcýya ait veri yoksa yeni bir kayýt ekle
    IF NOT EXISTS (SELECT 1 FROM ProgressTracking WHERE KullaniciID = @KullaniciID)
    BEGIN
        INSERT INTO ProgressTracking (KullaniciID, Kilo, VucutYagOrani, KasKutlesi, Tarih)
        VALUES (@KullaniciID, 70.00, 20.00, 30.00, GETDATE()); -- Varsayýlan deðerler eklenebilir
    END
END;
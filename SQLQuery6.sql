--UserExercises tablosuna yeni bir egzersiz kayd� eklendi�inde �al��acak ve ProgressTracking tablosundaki ilgili kullan�c� verilerini g�ncelleyecektir. 
--Ayr�ca, e�er kullan�c� i�in ProgressTracking tablosunda bir veri yoksa, yeni bir kay�t ekleyecektir.
CREATE TRIGGER trg_UpdateProgressTracking
ON UserExercises
AFTER INSERT
AS
BEGIN
    DECLARE @KullaniciID INT, @EgzersizSuresi INT;

    -- Yeni eklenen egzersizin KullaniciID ve EgzersizSuresi'ni al
    SELECT @KullaniciID = KullaniciID, @EgzersizSuresi = EgzersizSuresi
    FROM INSERTED;

    -- Kullan�c�n�n ilerleme takibini g�ncelle
    UPDATE ProgressTracking
    SET Kilo = Kilo - (@EgzersizSuresi * 0.04), -- Egzersiz s�resi kadar kilo kayb�
        VucutYagOrani = VucutYagOrani - (@EgzersizSuresi * 0.02), -- V�cut ya� oran�nda bir azalma
        KasKutlesi = KasKutlesi + (@EgzersizSuresi * 0.01) -- Kas k�tlesi art���
    WHERE KullaniciID = @KullaniciID;
    
    -- E�er ProgressTracking tablosunda o kullan�c�ya ait veri yoksa yeni bir kay�t ekle
    IF NOT EXISTS (SELECT 1 FROM ProgressTracking WHERE KullaniciID = @KullaniciID)
    BEGIN
        INSERT INTO ProgressTracking (KullaniciID, Kilo, VucutYagOrani, KasKutlesi, Tarih)
        VALUES (@KullaniciID, 70.00, 20.00, 30.00, GETDATE()); -- Varsay�lan de�erler eklenebilir
    END
END;
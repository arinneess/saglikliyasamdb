--UserDiets tablosuna yeni bir diyet kayd� eklendi�inde kullan�c� hedeflerini g�nceller veya yeni bir hedef olu�turur
CREATE TRIGGER UpdateUserGoalsOnNewDiet
ON UserDiets
AFTER INSERT
AS
BEGIN
    DECLARE @KullaniciID INT, @DiyetID INT;
    
    -- Birden fazla sat�r i�in i�lem yapabilmek i�in cursor kullan�yoruz
    DECLARE cur CURSOR FOR 
        SELECT KullaniciID, DiyetID 
        FROM INSERTED;
        
    OPEN cur;
    FETCH NEXT FROM cur INTO @KullaniciID, @DiyetID;

    -- Cursor ile her kullan�c� i�in i�lem yap�yoruz
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Diyet kayd� eklenirse, kullan�c�n�n hedeflerini g�nceller
        IF EXISTS (SELECT 1 FROM Goals WHERE KullaniciID = @KullaniciID)
        BEGIN
            -- E�er kullan�c�n�n hedefi varsa, g�nceller
            UPDATE Goals
            SET HedefTuru = 'Beslenme D�zeni De�i�tirildi', 
                BeklenenBitisTarihi = DATEADD(MONTH, 3, GETDATE())
            WHERE KullaniciID = @KullaniciID;
        END
        ELSE
        BEGIN
            -- E�er daha �nce hedef yoksa, yeni bir hedef olu�turur
            INSERT INTO Goals (KullaniciID, HedefTuru, BaslangicTarihi, BeklenenBitisTarihi)
            VALUES (@KullaniciID, 'Beslenme D�zeni De�i�tirildi', GETDATE(), DATEADD(MONTH, 3, GETDATE()));
        END

        FETCH NEXT FROM cur INTO @KullaniciID, @DiyetID;
    END

    CLOSE cur;
    DEALLOCATE cur;
END;
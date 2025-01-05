--UserDiets tablosuna yeni bir diyet kaydý eklendiðinde kullanýcý hedeflerini günceller veya yeni bir hedef oluþturur
CREATE TRIGGER UpdateUserGoalsOnNewDiet
ON UserDiets
AFTER INSERT
AS
BEGIN
    DECLARE @KullaniciID INT, @DiyetID INT;
    
    -- Birden fazla satýr için iþlem yapabilmek için cursor kullanýyoruz
    DECLARE cur CURSOR FOR 
        SELECT KullaniciID, DiyetID 
        FROM INSERTED;
        
    OPEN cur;
    FETCH NEXT FROM cur INTO @KullaniciID, @DiyetID;

    -- Cursor ile her kullanýcý için iþlem yapýyoruz
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Diyet kaydý eklenirse, kullanýcýnýn hedeflerini günceller
        IF EXISTS (SELECT 1 FROM Goals WHERE KullaniciID = @KullaniciID)
        BEGIN
            -- Eðer kullanýcýnýn hedefi varsa, günceller
            UPDATE Goals
            SET HedefTuru = 'Beslenme Düzeni Deðiþtirildi', 
                BeklenenBitisTarihi = DATEADD(MONTH, 3, GETDATE())
            WHERE KullaniciID = @KullaniciID;
        END
        ELSE
        BEGIN
            -- Eðer daha önce hedef yoksa, yeni bir hedef oluþturur
            INSERT INTO Goals (KullaniciID, HedefTuru, BaslangicTarihi, BeklenenBitisTarihi)
            VALUES (@KullaniciID, 'Beslenme Düzeni Deðiþtirildi', GETDATE(), DATEADD(MONTH, 3, GETDATE()));
        END

        FETCH NEXT FROM cur INTO @KullaniciID, @DiyetID;
    END

    CLOSE cur;
    DEALLOCATE cur;
END;
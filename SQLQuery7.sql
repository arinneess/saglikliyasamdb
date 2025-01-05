--Kullanýcý verilerini Users tablosuna ekler. Eðer iþlem sýrasýnda bir hata oluþursa, iþlem geri alýnýr ve hata mesajý yazdýrýlýr. 
--Eðer iþlem baþarýlý olursa, yapýlan deðiþiklikler kalýcý hale getirilir.

BEGIN TRANSACTION;  -- Transaction baþlat

BEGIN TRY
    -- Veritabanýna veri ekleme iþlemi
    INSERT INTO Users (Ad, Soyad, Eposta, Sifre, DogumTarihi, Boy, Kilo, Cinsiyet, VucutTipi, KanDegerleri, TansiyonSeviyesi, DigerSaglikNotlari)
    VALUES ('Mehmet', 'Kaya', 'mehmet.kaya@gmail.com', 'password123', '1990-01-01', 175.00, 80.00, 'Erkek', 'Normal', 'Normal', '120/80', 'Saðlýklý');
    
    -- Eðer yukarýdaki iþlem baþarýlý olursa commit iþlemi yapýlýr
    COMMIT;  -- Deðiþiklikleri kalýcý hale getirir
END TRY
BEGIN CATCH
    -- Hata durumunda yapýlacak iþlemler:
    ROLLBACK;  -- Hatalý durumda yapýlan deðiþiklikleri geri alýr
    
    -- Hata mesajýný yazdýrýr
    PRINT 'Bir hata oluþtu: ' + ERROR_MESSAGE();
END CATCH;
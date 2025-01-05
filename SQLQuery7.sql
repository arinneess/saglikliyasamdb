--Kullan�c� verilerini Users tablosuna ekler. E�er i�lem s�ras�nda bir hata olu�ursa, i�lem geri al�n�r ve hata mesaj� yazd�r�l�r. 
--E�er i�lem ba�ar�l� olursa, yap�lan de�i�iklikler kal�c� hale getirilir.

BEGIN TRANSACTION;  -- Transaction ba�lat

BEGIN TRY
    -- Veritaban�na veri ekleme i�lemi
    INSERT INTO Users (Ad, Soyad, Eposta, Sifre, DogumTarihi, Boy, Kilo, Cinsiyet, VucutTipi, KanDegerleri, TansiyonSeviyesi, DigerSaglikNotlari)
    VALUES ('Mehmet', 'Kaya', 'mehmet.kaya@gmail.com', 'password123', '1990-01-01', 175.00, 80.00, 'Erkek', 'Normal', 'Normal', '120/80', 'Sa�l�kl�');
    
    -- E�er yukar�daki i�lem ba�ar�l� olursa commit i�lemi yap�l�r
    COMMIT;  -- De�i�iklikleri kal�c� hale getirir
END TRY
BEGIN CATCH
    -- Hata durumunda yap�lacak i�lemler:
    ROLLBACK;  -- Hatal� durumda yap�lan de�i�iklikleri geri al�r
    
    -- Hata mesaj�n� yazd�r�r
    PRINT 'Bir hata olu�tu: ' + ERROR_MESSAGE();
END CATCH;
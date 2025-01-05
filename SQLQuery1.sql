-- Kullanýcýlar tablosu
CREATE TABLE Users (
    KullaniciID INT PRIMARY KEY IDENTITY(1,1),
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    Eposta NVARCHAR(100) UNIQUE NOT NULL,
    Sifre NVARCHAR(100) NOT NULL,
    DogumTarihi DATE,
    Boy DECIMAL(5,2),
    Kilo DECIMAL(5,2),
    Cinsiyet NVARCHAR(10),
    VucutTipi NVARCHAR(50),
    KanDegerleri NVARCHAR(MAX),
    TansiyonSeviyesi NVARCHAR(50),
    DigerSaglikNotlari NVARCHAR(MAX),
    KayitTarihi DATETIME DEFAULT GETDATE()
);

-- Yöneticiler tablosu
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    Eposta NVARCHAR(100) UNIQUE NOT NULL,
    Sifre NVARCHAR(100) NOT NULL
);

-- Çalýþanlar tablosu
CREATE TABLE Staff (
    CalisanID INT PRIMARY KEY IDENTITY(1,1),
    AdminID INT FOREIGN KEY REFERENCES Admins(AdminID) ON DELETE CASCADE,
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    Pozisyon NVARCHAR(50),
    Telefon NVARCHAR(15),
    Eposta NVARCHAR(100) UNIQUE,
    UzmanlikAlani NVARCHAR(100)
);

-- Spor hareketleri tablosu
CREATE TABLE FitnessMovements (
    HareketID INT PRIMARY KEY IDENTITY(1,1),
    CalisanID INT FOREIGN KEY REFERENCES Staff(CalisanID) ON DELETE SET NULL,
    HareketAdi NVARCHAR(100) NOT NULL,
    HareketTuru NVARCHAR(50),
    EkipmanGereksinimi NVARCHAR(100),
    KasGrubu NVARCHAR(100),
    KaloriYakimi DECIMAL(7,2)  
);

-- Diyetler tablosu
CREATE TABLE Diets (
    DiyetID INT PRIMARY KEY IDENTITY(1,1),
    CalisanID INT FOREIGN KEY REFERENCES Staff(CalisanID) ON DELETE SET NULL,
    DiyetAdi NVARCHAR(100) NOT NULL,
    DiyetTuru NVARCHAR(50),
    KaloriMiktari DECIMAL(7,2),
    ProteinOrani DECIMAL(5,2),
    KarbonhidratOrani DECIMAL(5,2),
    YagOrani DECIMAL(5,2)
);

-- Egzersiz programlarý tablosu
CREATE TABLE ExercisePrograms (
    ProgramID INT PRIMARY KEY IDENTITY(1,1),
    CalisanID INT FOREIGN KEY REFERENCES Staff(CalisanID) ON DELETE SET NULL,
    ProgramAdi NVARCHAR(100) NOT NULL,
    ProgramTuru NVARCHAR(50),
    GunlukEgzersizSuresi INT
);

-- Kullanýcý diyetleri tablosu
CREATE TABLE UserDiets (
    KullaniciDiyetID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT FOREIGN KEY REFERENCES Users(KullaniciID) ON DELETE CASCADE,
    DiyetID INT FOREIGN KEY REFERENCES Diets(DiyetID) ON DELETE CASCADE,
    BaslangicTarihi DATE,
    BitisTarihi DATE
);

-- Kullanýcý egzersizleri tablosu
CREATE TABLE UserExercises (
    KullaniciEgzersizID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT FOREIGN KEY REFERENCES Users(KullaniciID) ON DELETE CASCADE,
    HareketID INT FOREIGN KEY REFERENCES FitnessMovements(HareketID) ON DELETE CASCADE,
    EgzersizSuresi INT,
    Tarih DATE
);

-- Ýlerleme takibi tablosu
CREATE TABLE ProgressTracking (
    IlerlemeID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT FOREIGN KEY REFERENCES Users(KullaniciID) ON DELETE CASCADE,
    Kilo DECIMAL(5,2),
    VucutYagOrani DECIMAL(5,2),
    KasKutlesi DECIMAL(5,2),
    Tarih DATE
);

-- Vücut ölçümleri tablosu
CREATE TABLE BodyMeasurements (
    OlcumID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT FOREIGN KEY REFERENCES Users(KullaniciID) ON DELETE CASCADE,
    GogusCevresi DECIMAL(5,2),
    BelCevresi DECIMAL(5,2),
    KalcaCevresi DECIMAL(5,2),
    KolCevresi DECIMAL(5,2),
    Tarih DATE
);

-- Kullanýcý hedefleri tablosu
CREATE TABLE Goals (
    HedefID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT FOREIGN KEY REFERENCES Users(KullaniciID) ON DELETE CASCADE,
    HedefTuru NVARCHAR(50),
    BaslangicTarihi DATE,
    BeklenenBitisTarihi DATE
);

-- Program hareket tablosu
CREATE TABLE ProgramMovements (
    ProgramHareketID INT PRIMARY KEY IDENTITY(1,1),
    ProgramID INT FOREIGN KEY REFERENCES ExercisePrograms(ProgramID) ON DELETE CASCADE,
    HareketID INT FOREIGN KEY REFERENCES FitnessMovements(HareketID) ON DELETE CASCADE,
    SetSayisi INT,
    TekrarSayisi INT
);
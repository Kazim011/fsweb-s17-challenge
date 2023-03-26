-- Tasarımını yaptığınız tabloları oluşturan sql ifadeleri buraya yazınız.
-- veri tiplerine, nullable olma durumuna, default değerine ve tablolar arası foreign key kullanımına dikkat.
CREATE TABLE `urunler` (
  `urun_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `urun_adi` varchar(255) NOT NULL,
  `aciklama` text NOT NULL,
  `fiyat` decimal(10,2) NOT NULL,
  `stok` int NOT NULL,
  `resim` varchar(255) DEFAULT NULL,
);

CREATE TABLE `kullanicilar` (
  `kullanici_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `ad` varchar(255) NOT NULL,
  `soyad` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `sifre` varchar(255) NOT NULL,
  `telefon` varchar(20) DEFAULT NULL,
) ;

CREATE TABLE `siparisler` (
  `siparis_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `kullanici_id` int NOT NULL,
  `urun_id` int NOT NULL,
  `adet` int NOT NULL,
  `toplam_tutar` decimal(10,2) NOT NULL,
  `tarih` datetime default NOT NULL,
 FOREIGN KEY (`kullanici_id`) REFERENCES `kullanicilar` (`kullanici_id`) ON DELETE CASCADE,
 FOREIGN KEY (`urun_id`) REFERENCES `urunler` (`urun_id`) ON DELETE CASCADE
);

CREATE TABLE `adresler` (
  `adres_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `kullanici_id` int NOT NULL,
  `adres_basligi` varchar(255) NOT NULL,
  `adres` text NOT NULL,
  `sehir` varchar(255) NOT NULL,
  `posta_kodu` varchar(10) NOT NULL,
  FOREIGN KEY (`kullanici_id`) REFERENCES `kullanicilar` (`kullanici_id`) ON DELETE CASCADE
);

CREATE TABLE `sepet` (
  `sepet_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `kullanici_id` int NOT NULL,
  `urun_id` int NOT NULL,
  `adet` int NOT NULL,
  FOREIGN KEY (`kullanici_id`) REFERENCES `kullanicilar` (`kullanici_id`) ON DELETE CASCADE,
  FOREIGN KEY (`urun_id`) REFERENCES `urunler` (`urun_id`) ON DELETE CASCADE
);

CREATE TABLE `iade` (
  `iade_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `siparis_id` int NOT NULL,
  `urun_id` int NOT NULL,
  `kullanici_id` int NOT NULL,
  `aciklama` text,
  `islem_tarihi` datetime default NOT NULL,
  `durum` enum('Beklemede','İşlemde','Tamamlandı') NOT NULL,
  FOREIGN KEY (`siparis_id`) REFERENCES `siparisler` (`siparis_id`) ON DELETE CASCADE,
  FOREIGN KEY (`urun_id`) REFERENCES `urunler` (`urun_id`) ON DELETE CASCADE,
  FOREIGN KEY (`kullanici_id`) REFERENCES `kullanicilar` (`kullanici_id`) ON DELETE CASCADE
);

CREATE TABLE `inceleme` (
  `inceleme_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `kullanici_id` int NOT NULL,
  `urun_id` int NOT NULL,
  `yorum` text NOT NULL,
  `puan` tinyint(4) NOT NULL,
  `tarih` datetime default NOT NULL,
  FOREIGN KEY (`kullanici_id`) REFERENCES `kullanicilar` (`kullanici_id`) ON DELETE CASCADE,
  FOREIGN KEY (`urun_id`) REFERENCES `urunler` (`urun_id`) ON DELETE CASCADE
);

CREATE TABLE `odeme` (
  `odeme_id` int NOT NULL AUTO_INCREMENT  PRIMARY KEY,
  `kullanici_id` int NOT NULL,
  `siparis_id` int NOT NULL,
  `odeme_turu` enum('Kredi Kartı','Nakit') NOT NULL,
  `tutar` decimal(10,2) NOT NULL,
  `odeme_tarihi` datetime default NOT NULL,
  FOREIGN KEY (`kullanici_id`) REFERENCES `kullanicilar` (`kullanici_id`) ON DELETE CASCADE,
  FOREIGN KEY (`siparis_id`) REFERENCES `siparisler` (`siparis_id`) ON DELETE CASCADE
);

CREATE TABLE `kargo` (
  `kargo_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `siparis_id` int NOT NULL,
  `kargo_sirketi` varchar(255) NOT NULL,
  `kargo_numarasi` varchar(255) NOT NULL,
  `tarih` datetime default NOT NULL,
  FOREIGN KEY (`siparis_id`) REFERENCES `siparisler` (`siparis_id`) ON DELETE CASCADE
);







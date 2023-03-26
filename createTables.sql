-- Tasarımını yaptığınız tabloları oluşturan sql ifadeleri buraya yazınız.
-- veri tiplerine, nullable olma durumuna, default değerine ve tablolar arası foreign key kullanımına dikkat.
CREATE TABLE `urunler`(
    `urun_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `urun_adi` TEXT NOT NULL,
    `urun_detaylari` TEXT NOT NULL,
    `urun_fiyati` DOUBLE NOT NULL,
    `siparis_id` BIGINT NOT NULL,
    PRIMARY KEY (`urun_id`)
);

CREATE TABLE `kategoriler`(
    `kategori_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `kategori_adi` TEXT NOT NULL,
    PRIMARY KEY (`kategori_id`)
);

CREATE TABLE `urun_kategori`(
    `urun_id` BIGINT NOT NULL,
    `kategori_id` BIGINT NOT NULL
);
CREATE TABLE `kullanıcı`(
    `kullanici_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `kullanici_adi` TEXT NOT NULL,
    `kullanici_soyadi` TEXT NOT NULL,
    `kullanici_eposta` TEXT NOT NULL,
    `kullanici_telefon` INT NOT NULL,
    `kullanici_adres` TEXT NOT NULL,
    PRIMARY KEY (`kullanici_id`)
);

CREATE TABLE `siparisler`(
    `siparis_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `kullanici_id` BIGINT NOT NULL,
    `siparis_tarihi` DATETIME NOT NULL,
    `teslimat_tarihi` DATETIME NOT NULL,
    `durum` TEXT NOT NULL,
    PRIMARY KEY (`siparis_id`)
);

CREATE TABLE `magaza_urunler`(
    `magaza_id` BIGINT NOT NULL,
    `urun_id` BIGINT NOT NULL
);
CREATE TABLE `magazalar`(
    `magaza_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `magaza_adi` TEXT NOT NULL,
    `magaza_adres` TEXT NOT NULL,
    PRIMARY KEY (`magaza_id`)
);

ALTER TABLE
    `urunler` ADD CONSTRAINT `urunler_siparis_id_foreign` FOREIGN KEY(`siparis_id`) REFERENCES `siparisler`(`siparis_id`);
ALTER TABLE
    `magaza_urunler` ADD CONSTRAINT `magaza_urunler_magaza_id_foreign` FOREIGN KEY(`magaza_id`) REFERENCES `magazalar`(`magaza_id`);
ALTER TABLE
    `urun_kategori` ADD CONSTRAINT `urun_kategori_urun_id_foreign` FOREIGN KEY(`urun_id`) REFERENCES `urunler`(`urun_id`);
ALTER TABLE
    `urun_kategori` ADD CONSTRAINT `urun_kategori_kategori_id_foreign` FOREIGN KEY(`kategori_id`) REFERENCES `kategoriler`(`kategori_id`);
ALTER TABLE
    `magaza_urunler` ADD CONSTRAINT `magaza_urunler_urun_id_foreign` FOREIGN KEY(`urun_id`) REFERENCES `urunler`(`urun_id`);
ALTER TABLE
    `siparisler` ADD CONSTRAINT `siparisler_kullanici_id_foreign` FOREIGN KEY(`kullanici_id`) REFERENCES `kullanıcı`(`kullanici_id`);
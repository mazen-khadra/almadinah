CREATE SCHEMA IF NOT EXISTS `islamk_mojammaa` DEFAULT CHARACTER SET utf8mb4;
USE `islamk_mojammaa`;

-- -----------------------------------------------------
-- Table `strings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `strings` (
 `IdStr` 	 BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
 `EnStr`       LONGTEXT NULL,
 `ArStr`       LONGTEXT NULL DEFAULT NULL,
  
  PRIMARY KEY (`IdStr`)

  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
-- -----------------------------------------------------
-- Table `enum_fields`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `enum_fields` (
  `IdEnumField`		INT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TableName`			VARCHAR(50) NOT NULL, 
  `FieldName`			VARCHAR(50) NOT NULL,
  `value`				  SMALLINT NOT NULL,
  `meaning`       VARCHAR(50) NOT NULL, 


  PRIMARY KEY (`IdEnumField`)
  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ===================================================================================
-- -----------------------------------------------------
-- Table countries
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `countries` (
  `IdCountry`		  INT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NameStrId`	BIGINT(20) UNSIGNED NOT NULL, 
      
  PRIMARY KEY (`IdCountry`),

   CONSTRAINT `FK_countries_strings`
    FOREIGN KEY (`NameStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table cities
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `cities` (
  `IdCity`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NameStrId`	          BIGINT(20) UNSIGNED NOT NULL, 
  `CountryId`           INT(20) UNSIGNED NOT NULL,
      
  PRIMARY KEY (`IdCity`),

   CONSTRAINT `FK_cities_strings`
    FOREIGN KEY (`NameStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_cities_countries`
    FOREIGN KEY (`CountryId`)
    REFERENCES `countries` (`IdCountry`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table imgs
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `imgs` (
  `IdImg`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Url`	              VARCHAR(500) NOT NULL,
  `Img`               mediumblob NULL,
  `SizeInBytes`       INT(10) UNSIGNED NULL,
      
  PRIMARY KEY (`IdImg`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ===================================================================================


-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `IdUser` 							  BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `FirstName` 					  NVARCHAR(50) NOT NULL,
  `LastName` 						  NVARCHAR(50) NOT NULL, 
  `PersonalEmail` 			  NVARCHAR(50) NOT NULL UNIQUE,
  `Password` 						  NVARCHAR(50) NOT NULL,
  `MobilePhone` 				  NVARCHAR(50) NULL DEFAULT NULL,
  `BirthDate` 					  DATETIME NOT NULL,
  `ZipCode` 						  NVARCHAR(50) NULL DEFAULT NULL,
  `Gender` 							  SMALLINT(1) NOT NULL, -- [Male, Female]
  `Active`                BOOLEAN NOT NULL DEFAULT FALSE,
  `ActivationCode` 				varchar(100) NULL DEFAULT NULL,
  `ResetPassWordCode` 		varchar(100) NULL DEFAULT NULL,
  `Role`                  SMALLINT NOT NULL DEFAULT 1, -- ['normal user']
  `CountryId`             INT(20) UNSIGNED NULL DEFAULT NULL,
  `CityId`                BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  `Photo`                 BIGINT(20) UNSIGNED NULL DEFAULT NULL,

  `Deleted`               BOOLEAN NOT NULL DEFAULT FALSE,
  `DeletedTimestamp`      DATETIME NULL DEFAULT NULL,

  PRIMARY KEY (`IdUser`) ,
  
  CONSTRAINT `FK_users_countries`
    FOREIGN KEY (`CountryId` )
    REFERENCES `countries` (`IdCountry` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_users_cities`
    FOREIGN KEY (`CityId` )
    REFERENCES `cities` (`IdCity` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_users_imgs`
    FOREIGN KEY (`Photo` )
    REFERENCES `imgs` (`IdImg` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `users_permissions`
-- ----------------------------------------------------- 


-- =========================================================================
-- -----------------------------------------------------
-- Table sections
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `sections` (
  `IdSection`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NameStrId`	            BIGINT(20) UNSIGNED NOT NULL,
  `ImgId`                 BIGINT(20) UNSIGNED NULL,
  `Visible`               BOOLEAN NOT NULL DEFAULT TRUE,
  `DisplayOrder`          SMALLINT(2) NULL DEFAULT NULL,

  PRIMARY KEY (`IdSection`),

  CONSTRAINT `FK_sections_strings`
    FOREIGN KEY (`NameStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_sections_imgs`
    FOREIGN KEY (`ImgId`)
    REFERENCES `imgs` (`IdImg`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table doors
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `doors` (
  `IdDoor`		            BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NameStrId`	            BIGINT(20) UNSIGNED NOT NULL,
  `ImgId`                 BIGINT(20) UNSIGNED NULL,
  `SectionId`             BIGINT(20) UNSIGNED NOT NULL,
  `Visible`               BOOLEAN NOT NULL DEFAULT TRUE,
  `MobileAppKey`          VARCHAR(50) NULL DEFAULT NULL,
  `DisplayOrder`          SMALLINT(2) NULL DEFAULT NULL,

  PRIMARY KEY (`IdDoor`),

  CONSTRAINT `FK_doors_strings`
    FOREIGN KEY (`NameStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_doors_sections`
    FOREIGN KEY (`SectionId`)
    REFERENCES `sections` (`IdSection`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_doors_imgs`
    FOREIGN KEY (`ImgId`)
    REFERENCES `imgs` (`IdImg`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table articles
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `articles` (
  `IdArticle`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `titleStrId`	          BIGINT(20) UNSIGNED NOT NULL,
  `ImgId`                 BIGINT(20) UNSIGNED NULL,
  `txtStrId`              BIGINT(20) UNSIGNED NULL,
  
  PRIMARY KEY (`IdArticle`),

  CONSTRAINT `FK_articles_strings`
    FOREIGN KEY (`titleStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_articles_txt_strings`
    FOREIGN KEY (`txtStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_articles_imgs`
    FOREIGN KEY (`ImgId`)
    REFERENCES `imgs` (`IdImg`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table articles_paragraphs
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles_paragraphs` (
  `IdParagraph`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `titleStrId`	            BIGINT(20) UNSIGNED NULL,
  `ImgId`                   BIGINT(20) UNSIGNED NULL,
  `txtStrId`                BIGINT(20) UNSIGNED NOT NULL,
  `ArticleId`               BIGINT(20) UNSIGNED NULL,

  PRIMARY KEY (`IdParagraph`),

  CONSTRAINT `FK_paragraphs_strings`
    FOREIGN KEY (`titleStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_paragraphs_txt_strings`
    FOREIGN KEY (`txtStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_paragraphs_imgs`
    FOREIGN KEY (`ImgId`)
    REFERENCES `imgs` (`IdImg`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_paragraphs_articles`
    FOREIGN KEY (`ArticleId`)
    REFERENCES `articles` (`IdArticle`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table articles_categories
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles_categories` (
  `ArticleId`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Category`              SMALLINT(2) UNSIGNED NULL, -- [FastingRules, Quarantine]
  
  CONSTRAINT `FK_category_articles`
    FOREIGN KEY (`ArticleId`)
    REFERENCES `articles` (`IdArticle`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table prayers
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prayers` (
  `IdPrayer`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NameStrId`	            BIGINT(20) UNSIGNED NOT NULL,
  `ImgId`                 BIGINT(20) UNSIGNED NULL,
  `DisplayOrder`          SMALLINT(2) NULL DEFAULT NULL,
  `ApiKeyName`            VARCHAR(50) NULL DEFAULT NULL,

  PRIMARY KEY (`IdPrayer`),

  CONSTRAINT `FK_prayers_strings`
    FOREIGN KEY (`NameStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_prayers_imgs`
    FOREIGN KEY (`ImgId`)
    REFERENCES `imgs` (`IdImg`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table congrats
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `congrats` (
  `IdCongrat`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NameStrId`	            BIGINT(20) UNSIGNED NOT NULL,
  `ImgId`                 BIGINT(20) UNSIGNED NULL,
    
  PRIMARY KEY (`IdCongrat`),

  CONSTRAINT `FK_congrats_strings`
    FOREIGN KEY (`NameStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_congrats_imgs`
    FOREIGN KEY (`ImgId`)
    REFERENCES `imgs` (`IdImg`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table imsakia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `imsakia` (
  `IdImsakia`		          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NameStrId`	            BIGINT(20) UNSIGNED NULL,
  `ImgId`                 BIGINT(20) UNSIGNED NULL,
  `CityId`                BIGINT(20) UNSIGNED NULL,
    
  PRIMARY KEY (`IdImsakia`),

  CONSTRAINT `FK_imsakia_strings`
    FOREIGN KEY (`NameStrId`)
    REFERENCES `strings` (`IdStr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_imsakia_imgs`
    FOREIGN KEY (`ImgId`)
    REFERENCES `imgs` (`IdImg`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_imsakia_city`
    FOREIGN KEY (`CityId`)
    REFERENCES `cities` (`IdCity`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -- -----------------------------------------------------
-- -- Table prayers_times
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `prayers_times` (
--   `PrayerId`		          BIGINT(20) UNSIGNED NOT NULL,
--   `AthanHour`	            SMALLINT(2) UNSIGNED NOT NULL,
--   `AthanMinutes`          SMALLINT(2) UNSIGNED NOT NULL,
--   `IqamahHour`	          SMALLINT(2) UNSIGNED NULL,
--   `IqamahMinutes`         SMALLINT(2) UNSIGNED NULL,
--   `CityId`                
--   -- `MethodId`            BIGINT(20) UNSIGNED NULL,
    
-- )

-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4;


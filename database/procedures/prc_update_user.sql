DELIMITER $$
CREATE PROCEDURE `prcUpdateUser` (
    IN p_FirstName NVARCHAR(50), 
    IN p_LastName  NVARCHAR(50),
    IN p_PersonalEmail NVARCHAR(50),
    IN p_MobilePhone NVARCHAR(50),
    IN p_BirthDate DATETIME,
    IN p_ZipCode NVARCHAR(50),
    IN p_Gender SMALLINT(1), -- [Male, Female]
    IN p_country_id INT(20) UNSIGNED,
    IN p_city_id   BIGINT(20) UNSIGNED,
    IN p_active BOOLEAN,
    IN p_user_id BIGINT(20) UNSIGNED
)
BEGIN

UPDATE 
  users 
SET 
  FirstName = CASE WHEN p_FirstName IS NOT NULL THEN p_FirstName ELSE FirstName END,
  LastName = CASE WHEN p_LastName IS NOT NULL THEN p_LastName ELSE LastName END,
  PersonalEmail = CASE WHEN p_PersonalEmail IS NOT NULL THEN p_PersonalEmail ELSE PersonalEmail END,
  MobilePhone = CASE WHEN p_MobilePhone IS NOT NULL THEN p_MobilePhone ELSE MobilePhone END,
  BirthDate = CASE WHEN p_BirthDate IS NOT NULL THEN p_BirthDate ELSE BirthDate END,
  ZipCode = CASE WHEN p_ZipCode IS NOT NULL THEN p_ZipCode ELSE ZipCode END,
  Gender = CASE WHEN p_Gender IS NOT NULL THEN p_Gender ELSE Gender END,
  CountryId = CASE WHEN p_country_id IS NOT NULL THEN p_country_id ELSE CountryId END,
  CityId = CASE WHEN p_city_id  IS NOT NULL THEN p_city_id ELSE CityId END,
  Active = CASE WHEN p_active IS NOT NULL THEN p_active ELSE Active END
WHERE 
  IdUser = p_user_id
;

END$$
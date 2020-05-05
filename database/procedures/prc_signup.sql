DELIMITER $$
CREATE PROCEDURE `prcSignUP` (
    IN p_FirstName NVARCHAR(50), 
    IN p_LastName  NVARCHAR(50),
    IN p_PersonalEmail NVARCHAR(50),
    IN p_Password  NVARCHAR(50),
    IN p_MobilePhone NVARCHAR(50),
    IN p_BirthDate DATETIME,
    IN p_ZipCode NVARCHAR(50),
    IN p_Gender SMALLINT(1), -- [Male, Female]
    IN p_ActivationCode varchar(100),
    IN p_user_role SMALLINT,
    IN p_country_id INT(20) UNSIGNED,
    IN p_city_id   BIGINT(20) UNSIGNED
)
BEGIN

DECLARE new_user_id BIGINT(20) UNSIGNED;

INSERT INTO users (
    FirstName, LastName, PersonalEmail, Password, MobilePhone,
    BirthDate, ZipCode, Gender, ActivationCode, Role, CountryId, CityId
)
VALUES (
    p_FirstName, p_LastName, p_PersonalEmail, p_Password, p_MobilePhone,
    p_BirthDate, p_ZipCode, p_Gender, p_ActivationCode,
    CASE WHEN p_user_role IS NULL THEN 1 ELSE 2 END,
    p_country_id, p_city_id
);

SET new_user_id = LAST_INSERT_ID();

SELECT new_user_id;

END$$
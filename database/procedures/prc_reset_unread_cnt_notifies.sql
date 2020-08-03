DELIMITER $$
CREATE PROCEDURE `prcResetUserUnReadNotifiesCnt` (
  IN p_UserId BIGINT(20) UNSIGNED
)
BEGIN
    UPDATE
      notifications_users
    SET 
      IsRead = TRUE,
      ReadDateTime = UTC_TIMESTAMP()
    WHERE 
      userId = p_UserId     
    ;
END$$
DELIMITER $$
CREATE PROCEDURE `prcGetCategoryArticles` (
  p_lang SMALLINT(2) UNSIGNED,
  p_category SMALLINT(2) UNSIGNED
)
BEGIN
    SELECT 
        IdArticle id,
        funGetString(titleStrId, p_lang) title,
        imgs.URL imgURL
    FROM 
        articles_categories ac
        INNER JOIN articles a ON a.IdArticle = ac.ArticleId AND ac.Category = p_category
        LEFT JOIN imgs ON a.ImgId = imgs.IdImg
    ;
END$$
const mojamma = require('../../../bin/mojammaa');
const dbConnect = require('../../../database/connect');

module.exports = (app) => {
  app.post('/management/update/congrat/', (req, res) => {
    let {
      imgURL,
      name,
      congratId,
      categoryId
    } = req.body;
    
    imgURL = imgURL || null;
    name = name || null;
    categoryId = categoryId || null;

    if(!congratId) {
      res.status(400).end();
      return;
    }

    dbConnect.query(
      'CALL prcUpdateCongrat(?);', [[
        req.userLangPref,
        name,
        imgURL,
        congratId,
        categoryId
      ]],
      function (err) {
        if(err) {
          res.status(500).end();
          mojamma.log (
            `Error in Execution SQL Query: ${this.sql}\n` + err.message,
            mojamma.logLevels.DB_ERR,
            __filename,
            "app.post(/management/update/congrat)",
            null, err
          );
          return;
        }
        res.status(200).json({});
    });
  });  

  app.post('/management/add/congrat/', (req, res) => {
    let {
      imgURL,
      name,
      categoryId
    } = req.body;
    
    imgURL = imgURL || null;
    name = name || null;
    categoryId = categoryId || null;
  
    dbConnect.query(
      'CALL prcAddCongrat(?, @out_congrat_id);', [[
        req.userLangPref,
        name,
        imgURL,
        categoryId
      ]],
      function (err) {
        if(err) {
          res.status(500).end();
          mojamma.log (
            `Error in Execution SQL Query: ${this.sql}\n` + err.message,
            mojamma.logLevels.DB_ERR,
            __filename,
            "app.post(/management/add/congrat)",
            null, err
          );
          return;
        }
        res.status(200).json({});
    });
  });

};
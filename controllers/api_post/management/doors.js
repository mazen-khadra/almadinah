const mojamma = require('../../../bin/mojammaa');
const dbConnect = require('../../../database/connect');

module.exports = (app) => {
  app.post('/management/update/door/', (req, res) => {
    let {
      displayName,
      imageURI,
      sectionId,
      doorId
    } = req.body;
    
    displayName = displayName || null;
    imageURI = imageURI || null;
    sectionId = sectionId || null;

    if(!doorId) {
      res.status(400).end();
      return;
    }

    dbConnect.query(
      'CALL prcUpdateDoor(?);',
      [[req.userLangPref, displayName, imageURI, sectionId, doorId]],
      (err) => {
        if(err) {
          res.status(500).end();
          mojamma.log (
            `Error in Execution SQL Query: ${this.sql}\n` + err.message,
            mojamma.logLevels.DB_ERR,
            __filename,
            "app.post(/management/update/door/)",
            null, err
          );
          return;
        }
        res.status(200).json({});
    });

  });
  
  app.post('/management/add/door/', (req, res) => {
    const {
      displayName,
      imageURI,
      sectionId
    } = req.body;
    
    dbConnect.query (
      'CALL prcAddDoor(?, @out_door_id);',
      [[req.userLangPref, displayName, imageURI, sectionId]],
      (err) => {
        if(err) {
          res.status(500).end();
          mojamma.log (
            `Error in Execution SQL Query: ${this.sql}\n` + err.message,
            mojamma.logLevels.DB_ERR,
            __filename,
            "app.post(/management/add/door/)",
            null, err
          );
          return;
        }
        res.status(200).json({});
    });
  });
};
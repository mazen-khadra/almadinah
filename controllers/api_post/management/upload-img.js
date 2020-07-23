const mojamma = require('../../../bin/mojammaa');
const dbConnect = require('../../../database/connect');
const multer  = require('multer')
const upload = multer({ dest: 'uploads/' });
const ftpClient = new require('ftp')();

module.exports = (app) => {
  app.post('/management/upload/img', upload.single('picture'), function(req, res) {
  
  ftpClient.on('ready', function() {
  ftpClient.put(req.file.path, req.file.originalname, function(err) {
    if (err) {
      res.status(500).json({});
      mojamma.log (
        `Error in upload img to ftp server\n` + err,
        mojamma.logLevels.SERVER_ERR,
        __filename,
        "app.post(/management/upload/img)",
        null, err
      );
    }
      const imgUrl = "ftp://" + mojamma.config.ftp.host + 
        '/' + req.file.originalname;
      
      dbConnect.query(
        'SELECT funInsertImg(?);', [[
          imgUrl,
          null,
          req.file.size
        ]],
        function (err) {

          if(err) {
            mojamma.log (
              `Error in Execution SQL Query: ${this.sql}\n` + err.message,
              mojamma.logLevels.DB_ERR,
              __filename,
              "app.post(/management/upload/img)",
              null, err
            );
            return;
          }
        });
      
      res.status(200).json({imgUrl});

      ftpClient.end();
    });
  });

  
  ftpClient.on('error', function(err){
    res.status(500).json({});
    mojamma.log (
      `FTP Error:\n`,
      mojamma.logLevels.SERVER_ERR,
      __filename,
      "app.post(/management/upload/img)",
      null, err
    );
    return;
  });

  ftpClient.connect(mojamma.config.ftp);

  console.log(req.file);

  });
};
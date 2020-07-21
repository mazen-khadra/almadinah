var fs = require ('fs');

module.exports = (app, passport) => {
  
  app.get('/html/privacy-policy', (req, res) => {
    fs.readFile (
    __dirname + '/../../../views/privacy-policy/index.html',
    function (err, data) {
      if(err) {
        res.status(500).json(err);
        return;
      }
      res.end(data);
    });
  });

};
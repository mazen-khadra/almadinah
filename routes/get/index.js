let path = require('path');

module.exports = app => {  
  require('./auth')(app);
  require('./payment')(app);
  require('./customer')(app);
  require('./bill')(app);
  require('./report')(app);
  require('./cash-entry')(app);
  require('./withdraw')(app);
  require('./nitro')(app);

  app.get('/*', (req, res) => {
    res.status(200).sendFile(
      path.join(__dirname, '../../public/views/index.html')
    );
  });
};
const mojamma = require('../../../bin/mojammaa');
const dbConnect = require('../../../database/connect');

module.exports = (app) => {
  app.post('/management/user/update', (req, res) => {
    let {
      email,
      firstName,
      lastName,
      gender,
      birthDate,
      mobile,
      active,
      countryId,
      cityId,
      zipCode,
      address,
      nationalNumber,
      userId
    } = req.body;
    
    email = email || null;
    firstName = firstName || null;
    lastName = lastName || null;
    gender = gender || null;
    birthDate = birthDate || null;
    mobile = mobile || null;
    countryId = countryId || null;
    cityId = cityId || null;
    zipCode = zipCode || null;
    address = address || null;
    nationalNumber = nationalNumber || null;

    if(!userId) {
      res.status(400).end();
      return;
    }

    dbConnect.query(
      'CALL prcUpdateUser(?);', [[
        firstName,
        lastName,
        email, 
        mobile,
        birthDate,
        zipCode,
        gender,
        countryId, 
        cityId, 
        active,
        address,
        nationalNumber,
        userId
      ]],
      function (err) {
        if(err) {
          res.status(500).end();
          mojamma.log (
            `Error in Execution SQL Query: ${this.sql}\n` + err.message,
            mojamma.logLevels.DB_ERR,
            __filename,
            "app.post(/management/user/update)",
            null, err
          );
          return;
        }
        res.status(200).json({});
    });
  });
};
const mojamma = require('../../../bin/mojammaa');
const dbConnect = require('../../../database/connect');
const { FcmMsg, fcm } = require('../../../firebase');

module.exports = function (notification) {
  return new Promise((resolve) => {
    dbConnect.query('CALL prcGetAllInsIds();', function (err, fbInfoRows) {
      if (err) {
        mojamma.log(
          `Error in execution sql query: ${this.sql}` + err.message,
          lyfeup.logLevels.DB_ERR, __filename,
          "pushPublicNotification", null, err
        );
        return;
      }
      fbInfoRows = fbInfoRows[0];

      var fcmMsg = new FcmMsg(
        null,
        null,
        null,
        null,
        notification.title,
        notification.content,
        null,
        null,
        '#dddddd'
      );
      if (fbInfoRows.length === 0) {
        resolve({ status: 200 });
        return;
      }

      fcmMsg.tokens = fbInfoRows;
      
      fcm.send(fcmMsg)
        .then((response) => {
          mojamma.log(
            `Successfully sent message: ${response}`,
            mojamma.logLevels.FCM_INFO, __filename,
            "pushPublicNotification", null
          );
          resolve({ status: 200 });
        })
        .catch((error) => {
          mojamma.log(
            `Error sending message: ${error}`,
            lyfeup.logLevels.FCM_ERR, __filename,
            "pushPublicNotification", null
          );
          resolve({ status: 514 });
        });
    });
  });
}
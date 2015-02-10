

// quickblox
var QB = require('quickblox');
QB.init(CONFIG.appID, CONFIG.authKey, CONFIG.authSecret, CONFIG.debug);

// // create application session:
// QB.createSession(function(err, result) {
//   // callback function
// });

QB.createSession(TEST_USER, function(err, result) {
  // callback function
});

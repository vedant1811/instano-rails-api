

QB.init(CONFIG.appId, CONFIG.authKey, CONFIG.authSecret, CONFIG.debug);

// // create application session:
// QB.createSession(function(err, result) {
//   // callback function
// });

QB.createSession(TEST_USER, function(err, result) {
  // callback function
  console.log('callback')
  if (err) {
    console.log(err.detail);
  } else {
  }
});


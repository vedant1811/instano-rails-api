function sellerClicked(seller_id) {
  console.log("sellerClicked: " + seller_id);
}

require(['converse'], function (converse) {
  converse.initialize({
    auto_list_rooms: false,
    auto_subscribe: true,
    allow_registration: false,
    bosh_service_url: 'http://webchat.chatme.im/http-bind/',
    hide_muc_server: false,
    i18n: locales.en, // Refer to ./locale/locales.js to see which locales are supported
    prebind: false,
    keepalive: true,
    show_controlbox_by_default: false,
    roster_groups: true,
    debug: true,
    // In order to keep all IM clients for a user engaged in a conversation, outbound messages are carbon-copied to all interested resources.
    message_carbons: true,
    play_sounds: true
  });
  // means we have a new user
  converse.listen.on('noResumeableSession', function () {

  });
});

/*
"<query xmlns="jabber:iq:register"><instructions>Choose a username and password for use with this service.</instructions><username/><password/><x xmlns="jabber:x:data" type="form"><title>Creating a new account</title><instructions>Choose a username and password for use with this service.</instructions><field type="text-single" var="username" label="Username"><required/></field><field type="text-private" var="password" label="Password"><required/></field></x></query>"
*/

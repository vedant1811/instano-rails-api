function sellerClicked(seller_id) {
  console.log("sellerClicked: " + seller_id);
}

require(['converse'], function (converse) {
  converse.initialize({
    auto_list_rooms: false,
    auto_subscribe: true,
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

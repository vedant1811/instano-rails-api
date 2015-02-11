require(['converse'], function (converse) {
  converse.initialize({
    auto_list_rooms: false,
    auto_subscribe: true,
    bosh_service_url: 'https://bind.conversejs.org', // Please use this connection manager only for testing purposes
    hide_muc_server: false,
    i18n: locales.en, // Refer to ./locale/locales.js to see which locales are supported
    prebind: false,
    show_controlbox_by_default: true,
    roster_groups: true
    debug: true
    // In order to keep all IM clients for a user engaged in a conversation, outbound messages are carbon-copied to all interested resources.
    message_carbons: true
  });
});

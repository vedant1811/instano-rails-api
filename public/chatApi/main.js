//  var tempConn = new Strophe.Connection("http//myAWSDNS.com:7070/http-bind/");
//     tempConn.register.connect("myAWSDNS.com", function (status) {
//     if (status === Strophe.Status.REGISTER) {
//         // fill out the fields
//         connection.register.fields.username = "juliet";
//         connection.register.fields.password = "R0m30";
//         // calling submit will continue the registration process
//         connection.register.submit();
//     } else if (status === Strophe.Status.REGISTERED) {
//         console.log("registered!");
//         // calling login will authenticate the registered JID.
//         connection.authenticate();
//     } else if (status === Strophe.Status.CONFLICT) {
//         console.log("Contact already existed!");
//     } else if (status === Strophe.Status.NOTACCEPTABLE) {
//         console.log("Registration form not properly filled out.")
//     } else if (status === Strophe.Status.REGIFAIL) {
//         console.log("The Server does not support In-Band Registration")
//     } else if (status === Strophe.Status.CONNECTED) {
//         // do something after successful authentication
//     } else {
//         // Do other stuff
//     }
// });


function sellerClicked(seller) {

  var jid = (seller + "@instano.in");
  var name = seller;

  converse.chats.instano(jid, name, function() {
    converse.chats.get(jid);
  });

  /*
  converse.connection.roster.add(jid, name, [], function (iq) {
    converse.connection.roster.subscribe(jid, null, converse.xmppstatus.get('fullname'));
  });
  converse.chats.get(jid);
  */
}

require(['converse'], function (converse) {
  converse.initialize({
    auto_list_rooms: false,
    auto_subscribe: true,
    allow_registration: false,
    bosh_service_url: 'http://ec2-52-0-202-31.compute-1.amazonaws.com:7070/http-bind/',
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


/*

<form id="converse-register"><p class="provider-title">chatme.im</p>
<a href="https://xmpp.net/result.php?domain=chatme.im&amp;type=client">
<img class="provider-score" src="https://xmpp.net/badge.php?domain=chatme.im" alt="xmpp.net score">
</a>
<p class="title">Creating a new account</p>
<p class="instructions">Choose a username and password for use with this service.</p>

<label>
Username
</label>

<div class="input-group">
<input name="username" type="textline" class="required">
<span> @chatme.im</span>
</div>

<label>
Password
</label>

<input name="password" type="password" class="required">
<input type="submit" class="save-submit" value="Register"><input type="button" class="cancel-submit" value="Cancel"></form>

*/

require 'singleton'
require 'xmpp4r'
require 'xmpp4r/client'
include Jabber

SERVER = 'gcm.googleapis.com'
PORT = 5235

GCM_ID = 187047464172 # project number in goole developer console
API_KEY = 'AIzaSyDmnplvDn5Lpz88ovLLH3rYvXyOgR53O_I'

class GcmHandlerSingleton
  include Singleton

  attr_reader :client

  # chaning friendly
  def connect
    puts 'connecting'
    if !@client.nil? && @client.isConnected?
      return
    end

#     authenticationHelper = Jabber::SASL::Plain.new
#     authenticationHelper.auth(@jabber_password)

    @jabber_id = GCM_ID
    @jabber_password = API_KEY
    jid = JID.new(@jabber_id)
    @client = Client.new jid
    Jabber::debug = true
    @client.connect(SERVER, PORT)
#     @client.auth_sasl(authenticationHelper, @jabber_password)-  # Throws ClientAuthenticationFailure
  end

  def send_message message
    template = ("<message><gcm xmlns='google:mobile:data'>{1}</gcm></message>")

    message = Message.new(nil, messageString)
    message.type = :chat
    @client.send(message)
  end

#   on_stream_exception exception

end

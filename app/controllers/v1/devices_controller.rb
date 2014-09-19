require 'xmpp4r'
require 'xmpp4r/client'
include Jabber

SERVER = 'gcm.googleapis.com'
PORT = 5235

GCM_ID = 187047464172 # project number in goole developer console
API_KEY = 'AIzaSyDmnplvDn5Lpz88ovLLH3rYvXyOgR53O_I'

class V1::DevicesController < ApplicationController

  attr_reader :client

  before_filter :connect


  # GET /v1/devices
  # GET /v1/devices.json
  def index
    @v1_devices = V1::Device.all

    render json: @v1_devices
  end

  # GET /v1/devices/1
  # GET /v1/devices/1.json
  def show
    @v1_device = V1::Device.find(params[:id])

    render json: @v1_device
  end

  # POST /v1/devices
  # POST /v1/devices.json
  def create
    @v1_device = V1::Device.new(params[:v1_device])

    if @v1_device.save
      render json: @v1_device, status: :created, location: @v1_device
    else
      render json: @v1_device.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/devices/1
  # PATCH/PUT /v1/devices/1.json
  def update
    @v1_device = V1::Device.find(params[:id])

    if @v1_device.update(params[:v1_device])
      head :no_content
    else
      render json: @v1_device.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/devices/1
  # DELETE /v1/devices/1.json
  def destroy
    @v1_device = V1::Device.find(params[:id])
    @v1_device.destroy

    head :no_content
  end

  private
    # chaning friendly
    def connect
      if !@client.nil? && @client.isConnected?
	return
      end
      @jabber_id = GCM_ID
      @jabber_password = API_KEY
      jid = JID.new(@jabber_id)
      @client = Client.new jid
      Jabber::debug = true
      @client.connect(SERVER, PORT)
      @client.auth @jabber_password # Throws ClientAuthenticationFailure
    end

    def send_message message
      template = ("<message><gcm xmlns='google:mobile:data'>{1}</gcm></message>")

      message = Message.new(nil, messageString)
      message.type = :chat
      @client.send(message)
    end
end

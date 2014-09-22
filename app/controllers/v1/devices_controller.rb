class V1::DevicesController < ApplicationController

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
    @v1_device = V1::Device.new(device_params)

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
  def device_params
#     params.require(:de
  end
end

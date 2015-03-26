class V1::DevicesController < V1::ApiBaseController
  skip_before_filter :authorize_device!, :only => [:create]

  # POST /v1/devices
  # POST /v1/devices.json
  def create
    @v1_device = V1::Device.find_or_initialize_by(gcm_registration_id: device_params[:gcm_registration_id])
    errors = check_gcm_id

    if @v1_device.save # even if it is old device, check_gcm_id must have 'reset_session', so we should save it.
      # send GCM message to start a session
      if errors
        render json: errors, root: "GCM errors", status: :unprocessable_entity
      else
        render json: @v1_device, status: :ok
      end
    else
      render json: @v1_device.errors, status: :unprocessable_entity
    end
  end

private
  # also resets session_id on success (but does not save)
  def check_gcm_id

    if @v1_device.new_record? || !@v1_device.verified?
      # do sync call:
      jsonData = {
        registration_ids: [ @v1_device.gcm_registration_id ]
        }.to_json

      uri = URI.parse('https://android.googleapis.com/gcm/send')

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new('/gcm/send')
      request.add_field('Authorization', "key=#{instano_buyer_gcm_app.auth_key}")
      request.add_field('Content-Type', 'application/json')
      request.body = jsonData
      response = http.request(request)
      response_hash = JSON.parse response.body
      puts response_hash.inspect
      if response_hash["success"] != 1
        # TODO: do more
        @v1_device.gcm_status = "error"
        return response_hash["results"]
      else
        @v1_device.gcm_status = "verified"
      end
    end
    # no error:
    return nil
  end

  def device_params
    params.require(:device).permit(:gcm_registration_id)
  end

  def instano_buyer_gcm_app
    app = Rpush::Gcm::App.find_by(name: "com.instano.buyer")
    if app.nil?
      app = Rpush::Gcm::App.new
      app.name = "com.instano.buyer"
      app.auth_key = "AIzaSyDmnplvDn5Lpz88ovLLH3rYvXyOgR53O_I"
      app.connections = 1
      app.save!
    end
    return app
  end
end

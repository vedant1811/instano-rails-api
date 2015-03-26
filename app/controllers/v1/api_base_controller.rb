# inside the actions, you are free to call @variables like @current_device
# the before_filter makes sure the request is authorized, and that @ variables are set
# subclasses adhere to this pattern
class V1::ApiBaseController < ApplicationController
  before_filter :authorize_device!
  helper_method :current_user

  def default_serializer_options
    {root: false}
  end

protected
  # for non-signed in users, just use the IP. be sure to override this method in respective controllers
  # rails admin controller already overrides this
  def current_user
    if current_device
      "device:id=#{@current_device.id}"
    else
      super
    end
  end

  # sets @current_device unless it is already set
  def current_device
    unless @current_device
      session_id = request.headers["Session-Id"]
      @current_device = V1::Device.find_by(session_id: session_id) unless session_id.nil?
    end
    return @current_device
  end
private
  # makes sure session id exists in database. renders 403 if it fails, halting any further rendering by any controller
  def authorize_device!
    if current_device.nil?
      render json: { error: "incorrect session_id"}, status: :forbidden
    end
  end
end

class ApplicationController < ActionController::Base

  def default_serializer_options
    {root: false}
  end

  helper_method :current_seller

  # for non-signed in users, just use the IP. be sure to override this method in respective controllers
  # rails admin controller already overrides this
  def current_user
    request.remote_ip
  end

  private

  def current_seller
    @current_seller ||= V1::Seller.find(session[:seller_id]) if session[:seller_id]
  end

end

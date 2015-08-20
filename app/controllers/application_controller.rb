class ApplicationController < ActionController::Base

  helper_method :current_seller

protected
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

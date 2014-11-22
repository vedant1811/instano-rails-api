class ApplicationController < ActionController::Base

  def index
    render 'public/homepage/index.html'
  end

  def staging
    render 'public/homepage/staging.html'
  end

  def default_serializer_options
    {root: false}
  end

  helper_method :current_seller

  private

  def current_seller
    @current_seller ||= V1::Seller.find(session[:seller_id]) if session[:seller_id]
  end

end

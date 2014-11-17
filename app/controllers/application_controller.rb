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
end

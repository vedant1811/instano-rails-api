class WelcomeController < ApplicationController

  def index
    render 'index.html'
  end

  def staging
    render 'public/homepage/staging.html'
  end
end

class WelcomeController < ApplicationController

  def index
    render 'index.html'
  end

  def staging
    render 'public/homepage/staging.html'
  end

  def test_mail
    InstanoMailer.test(params[:email]).deliver
    render :text => "mail sent"
  end
end

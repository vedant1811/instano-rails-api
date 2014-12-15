class InstanoMailer < ActionMailer::Base
  default from: "rajesh@instano.in"
  default to: "vedant.kota@gmail.com"

  def welcome_email(seller)
    @seller = seller
    @url  = 'http://instano.in/login'
    mail(to: @seller.email, cc: "info@instano.in", subject: 'Welcome to Instano')
  end

  def signup_error(seller)
    @seller = seller
    mail(subject: "signup_error") do |format|
      format.html { render :inline => "seller: <%= debug @seller.errors %>" }
    end
  end

  def error(error)
    @error = error
    mail(subject: "An error has occoured") do |format|
      format.html { render :inline => "seller: <%= debug @error.inspect %> <%= debug @error.backtrace %>" }
    end
  end
end

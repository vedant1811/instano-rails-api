class InstanoMailer < ActionMailer::Base
  default from: "business@instano.in"

  def welcome_email(seller)
    @seller = seller
    @url  = 'http://instano.in/login'
    mail(to: @seller.email, subject: 'Welcome to Instano')
  end
end

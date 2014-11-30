class InstanoMailer < ActionMailer::Base
  default from: "business@instano.in"

  def welcome_email(seller)
    @seller = seller
    @url  = 'http://instano.in/login'
    mail(to: @seller.email, subject: 'Welcome to Instano')
  end

  def test(email)
    mail(to: email, subject: "test") do |format|
      format.html { render :text => 'Welcome to Instano' }
    end
  end
end

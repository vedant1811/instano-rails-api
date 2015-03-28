class InstanoMailer < ActionMailer::Base
  # make sure to update default settings (in production.rb) as well
  default from: "rajesh@instano.in"
  default to: "instano@googlegroups.com"

  def welcome_email(seller)
    @seller = seller
    @url  = 'http://instano.in/login'
    mail(to: seller.email, subject: "Welcome to Instano")
  end

  def signup_error(seller)
    @seller = seller
    mail(to: "vedant@instano.in", subject: "signup_error") do |format|
      format.html { render :inline => "seller: <%= debug @seller.errors %>" }
    end
  end

  def error(error)
    @error = error
    mail(to: "vedant@instano.in", subject: "An error has occoured") do |format|
      format.html { render :inline => "error: <%= debug @error.inspect %> <%= debug @error.backtrace %>" }
    end
  end

  def notification(object)
    @object = object
    mail(subject: "[UPDATE] New #{object}")
  end
end

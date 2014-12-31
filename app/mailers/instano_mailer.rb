class InstanoMailer < ActionMailer::Base
  # make sure to update default settings (in production.rb) as well
  default from: "rajesh@instano.in"
  default to: "ranjan.rajesh004@gmail.com"

  def welcome_email(seller)
    @seller = seller
    @url  = 'http://instano.in/login'
    mail(to: seller.email, cc: "info@instano.in", subject: "Welcome to Instano")
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
      format.html { render :inline => "seller: <%= debug @error.inspect %> <%= debug @error.backtrace %>" }
    end
  end

  def new_quote(quote)
    @quote = quote
    mail(subject: "[UPDATE]New query from buyer") do |format|
      format.html { render :inline => "quote: <%= @quote.search_string %>" }
    end
  end

  def new_visitor(visitor)
    @visitor = visitor
    mail(subject: "[UPDATE]New Visitor")
  end

  def new_seller(seller)
    @seller = seller
    mail(subject: "[UPDATE]New Seller")
  end
end

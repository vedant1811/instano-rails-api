class WelcomeController < ApplicationController

  def index
    render 'index.html'
  end

  def subscribe
    visitor = V1::Visitor.create(visitor_params)
    InstanoMailer.notification(visitor).deliver_later
    render 'subscribe', formats: [:js]
  end

  def contact
    visitor = V1::Visitor.create(visitor_params)
    InstanoMailer.notification(visitor).deliver_later
    render 'contact', formats: [:js]
  end

  private

  def visitor_params
    params.permit(:name, :phone, :email, :message)
  end
end

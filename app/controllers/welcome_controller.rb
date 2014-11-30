class WelcomeController < ApplicationController

  def index
    render 'index.html'
  end

  def subscribe
    puts params
    visitor = V1::Visitor.create(visitor_params)
    render 'subscribe', formats: [:js]
  end

  def contact
    visitor = V1::Visitor.create(visitor_params)
    render 'contact', formats: [:js]
  end

  private

  def visitor_params
    params.permit(:name, :phone, :email, :message)
  end
end

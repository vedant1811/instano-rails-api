class WelcomeController < ApplicationController

  def index
    @visitor = V1::Visitor.new
    render 'index.html'
  end

  def subscribe
    visitor = V1::Visitor.create(visitor_params)
    respond_to do |format|
      render 'subscribe', formats: [:js]
    end
  end

  def visitor_params
    params.require(:visitor).permit(:email,:name,:message,:phone)
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    @seller = V1::Seller.authenticate(params[:email], params[:password])
    if @seller
      session[:seller_id] = @seller.id
      redirect_to sellers_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:seller_id] = nil
    redirect_to sellers_path, :notice => "Logged out!"
  end
end

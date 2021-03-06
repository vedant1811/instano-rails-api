class SellersController < ApplicationController

  def new
    @seller = V1::Seller.new
  end

  def index
    @seller = current_seller
    if @seller
      @quotes_for_seller = V1::Quote.with_seller_id(@seller.id)
    end
  end

  def profile
  end

  def categories
  end

  # GET /v1/sellers/1
  def show
    @seller = V1::Seller.find(params[:id])

    render json: @seller
  end

  # POST /v1/sellers
  # POST /v1/sellers.json
  def create
    @seller = V1::Seller.new(seller_params)

    if @seller.save
      redirect_to log_in_url, :notice => "Signed up!"
      # TODO: perform sign in instead and goto profile update
    else
      render 'new'
    end

  end

  # PATCH/PUT /v1/sellers/1
  # PATCH/PUT /v1/sellers/1.json
  def update
    @seller = V1::Seller.find(params[:id])

    if @seller.update(seller_params)
      @seller.assign_categories(params)
      render json: @seller.reload
    else
      render json: @seller.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/sellers/1
  # DELETE /v1/sellers/1.json
  def destroy
    @seller = V1::Seller.find(params[:id])
    @seller.destroy

    head :no_content
  end

private

  def seller_params # TODO make this stronger to require instead of permit
    params.require(:seller).permit(:name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone, :email, :password, :password_confirmation)
  end

  def authenticate_params
    params.require(:sign_in).permit(:email, :password)
  end

end

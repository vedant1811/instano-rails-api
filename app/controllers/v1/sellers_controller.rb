class V1::SellersController < ApplicationController

  # GET /v1/sellers
  # GET /v1/sellers.json
  def index
    @v1_sellers = V1::Seller.all
    render json: @v1_sellers
  end

  # GET /v1/sellers/1
  # GET /v1/sellers/1.json
  def show
    @v1_seller = V1::Seller.find(params[:id])

    render json: @v1_seller
  end

  def exists
    render json: { exists: V1::Seller.exists?(:email => params.require(:email)) }
  end

  def sign_in
    seller = V1::Seller.find_by(:email => authenticate_params.require(:email))
    authenticated = seller.authenticate(authenticate_params.require(:password))
    render json: authenticated
  end

  # POST /v1/sellers
  # POST /v1/sellers.json
  def create
    @v1_seller = V1::Seller.new(seller_params)

    if @v1_seller.save
      begin
        @v1_seller.assign_categories(params)
      rescue => e
        InstanoMailer.error(e).deliver
      end
      render json: @v1_seller.reload
    else
      InstanoMailer.signup_error(@v1_seller).deliver
      puts json: @v1_seller.errors
      render json: @v1_seller.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/sellers/1
  # PATCH/PUT /v1/sellers/1.json
  def update
    @v1_seller = V1::Seller.find(params[:id])

    if @v1_seller.update(seller_params)
      @v1_seller.assign_categories(params)
      render json: @v1_seller.reload
    else
      render json: @v1_seller.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/sellers/1
  # DELETE /v1/sellers/1.json
  def destroy
    @v1_seller = V1::Seller.find(params[:id])
    @v1_seller.destroy

    head :no_content
  end

private

  def seller_params # TODO make this stronger to require instead of permit
    params.require(:seller).permit(:name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone, :email, :password, :status)
  end

  def authenticate_params
    params.require(:sign_in).permit(:email, :password)
  end

end

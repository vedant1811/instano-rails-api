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

  # POST /v1/sellers
  # POST /v1/sellers.json
  def create
    @v1_seller = V1::Seller.new(seller_params)

    if @v1_seller.save
      render json: @v1_seller
    else
      render json: @v1_seller.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/sellers/1
  # PATCH/PUT /v1/sellers/1.json
  def update
    @v1_seller = V1::Seller.find(params[:id])

    if @v1_seller.update(params[:v1_seller])
      head :no_content
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

  # GET /v1/product_categories
  # GET /v1/product_categories.json
  def product_categories
    render json: V1::Seller.product_categories
  end

private

  def seller_params # TODO make this stronger to require instead of permit
    params.require(:seller).permit(:name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone, :email, :product_categories => [])
  end

end

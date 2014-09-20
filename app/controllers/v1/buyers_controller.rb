class V1::BuyersController < ApplicationController
  # GET /v1/buyers
  # GET /v1/buyers.json
  def index
    @v1_buyers = V1::Buyer.all

    render json: @v1_buyers
  end

  # GET /v1/buyers/1
  # GET /v1/buyers/1.json
  def show
    @v1_buyer = V1::Buyer.find(params[:id])

    render json: @v1_buyer
  end

  # POST /v1/buyers
  # POST /v1/buyers.json
  def create
    @v1_buyer = V1::Buyer.new(params[:v1_buyer])

    if @v1_buyer.save
      render json: @v1_buyer, status: :created, location: @v1_buyer
    else
      render json: @v1_buyer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/buyers/1
  # PATCH/PUT /v1/buyers/1.json
  def update
    @v1_buyer = V1::Buyer.find(params[:id])

    if @v1_buyer.update(params[:v1_buyer])
      head :no_content
    else
      render json: @v1_buyer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/buyers/1
  # DELETE /v1/buyers/1.json
  def destroy
    @v1_buyer = V1::Buyer.find(params[:id])
    @v1_buyer.destroy

    head :no_content
  end
end

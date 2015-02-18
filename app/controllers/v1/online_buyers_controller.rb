class V1::OnlineBuyersController < ApplicationController
  # GET /v1/online_buyers
  # GET /v1/online_buyers.json
  def index
    @v1_online_buyers = V1::OnlineBuyer.all

    render json: @v1_online_buyers
  end

  # GET /v1/online_buyers/1
  # GET /v1/online_buyers/1.json
  def show
    @v1_online_buyer = V1::OnlineBuyer.find(params[:id])

    render json: @v1_online_buyer
  end

  def exists
    render json: { exists: V1::OnlineBuyer.exists?(:phone => params.require(:phone)) }
  end

  # POST /v1/online_buyers
  # POST /v1/online_buyers.json
  def create
    @v1_online_buyer = V1::OnlineBuyer.new(online_buyer_params)

    if @v1_online_buyer.save
      render json: @v1_online_buyer, status: :created, location: @v1_online_buyer
    else
      render json: @v1_online_buyer.errors, status: :ok
    end
  end

  # PATCH/PUT /v1/online_buyers/1
  # PATCH/PUT /v1/online_buyers/1.json
  def update
    @v1_online_buyer = V1::OnlineBuyer.find(params[:id])

    if @v1_online_buyer.update(params[:v1_buyer])
      head :no_content
    else
      render json: @v1_online_buyer.errors, status: :ok
    end
  end

  # DELETE /v1/online_buyers/1
  # DELETE /v1/online_buyers/1.json
  def destroy
    @v1_online_buyer = V1::OnlineBuyer.find(params[:id])
    @v1_online_buyer.destroy

    head :no_content
  end

  private
  def online_buyer_params
    params.require(:online_buyer).permit(:name, :phone, :url, :message)
  end
end

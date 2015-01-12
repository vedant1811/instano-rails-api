class V1::DealsController < ApplicationController
  # GET /v1/deals
  # GET /v1/deals.json
  def index
    @v1_deals = V1::Deal.all
    render json: @v1_deals
  end

  # GET /v1/deals/1
  # GET /v1/deals/1.json
  def show
    @v1_deal = V1::Deal.find(params[:id])
    render json: @v1_deal
  end
end
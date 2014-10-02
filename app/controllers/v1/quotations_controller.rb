class V1::QuotationsController < ApplicationController
  # GET /v1/quotations
  # GET /v1/quotations.json
  def index
    @v1_quotations = V1::Quotation.all

    render json: @v1_quotations
  end

  def for_buyer
    buyer_id = params.require(:id)

    @v1_quotations_for_buyer_id = V1::Quotation.where(quote_id: V1::Quote.select(:id).where(buyer_id: buyer_id))
    render json: @v1_quotations_for_buyer_id
  end

  # GET /v1/quotations/1
  # GET /v1/quotations/1.json
  def show
    @v1_quotation = V1::Quotation.find(params[:id])

    render json: @v1_quotation
  end

  # POST /v1/quotations
  # POST /v1/quotations.json
  def create
    @v1_quotation = V1::Quotation.new(quotation_params)

    if @v1_quotation.save
      render json: @v1_quotation, status: :created, location: @v1_quotation
    else
      render json: @v1_quotation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/quotations/1
  # PATCH/PUT /v1/quotations/1.json
  def update
    @v1_quotation = V1::Quotation.find(params[:id])

    if @v1_quotation.update(params[:v1_quotation])
      head :no_content
    else
      render json: @v1_quotation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/quotations/1
  # DELETE /v1/quotations/1.json
  def destroy
    @v1_quotation = V1::Quotation.find(params[:id])
    @v1_quotation.destroy

    head :no_content
  end

private
  def quotation_params
    params.require(:quotation).permit(:name_of_product, :price, :description, :seller_id, :quote_id)
  end
end

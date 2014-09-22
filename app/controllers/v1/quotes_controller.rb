class V1::QuotesController < ApplicationController
  # GET /v1/quotes
  # GET /v1/quotes.json
  def index
    @v1_quotes = V1::Quote.all

    render json: @v1_quotes
  end

#   TODO:
#   def for_seller
#     seller_api_key = params.require(:api_key)
#     seller = V1::Seller.find(seller_api_key)
#     quotes_for_seller = Quote.where(
#   end

  # GET /v1/quotes/1
  # GET /v1/quotes/1.json
  def show
    @v1_quote = V1::Quote.find(params[:id])

    render json: @v1_quote
  end

  # POST /v1/quotes
  # POST /v1/quotes.json
  def create
    @v1_quote = V1::Quote.new(quote_params)

    if @v1_quote.save
      render json: @v1_quote, status: :created, location: @v1_quote
    else
      render json: @v1_quote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/quotes/1
  # PATCH/PUT /v1/quotes/1.json
  def update
    @v1_quote = V1::Quote.find(params[:id])

    if @v1_quote.update(params[:v1_quote])
      head :no_content
    else
      render json: @v1_quote.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/quotes/1
  # DELETE /v1/quotes/1.json
  def destroy
    @v1_quote = V1::Quote.find(params[:id])
    @v1_quote.destroy

    head :no_content
  end

private
  def quote_params
    params.require(:quote).permit(:buyer_id, :search_string, :brands, :price_range)
  end
end

class V1::QuotesController < V1::ApiBaseController
  before_filter :authorize_seller!, :only => [:sellers_index]
  before_filter :authorize_buyer!, :only => [:buyers_index, :create, :show, :update]

  # GET /v1/buyers/quotes
  # GET /v1/buyers/quotes.json
  def buyers_index
    @v1_quotes = V1::Quote.where(buyer: @current_buyer)
    render json: @v1_quotes
  end

  # renders quotes matching seller based on brand name
  def sellers_index
    @v1_quotes = V1::Quote.joins(:product).where(v1_products: { brand_name_id: @current_seller.brand_name_ids })
    render json: @v1_quotes
  end

  # POST /v1/buyers/quotes
  # POST /v1/buyers/quotes.json
  def create
    @v1_quote = V1::Quote.new(quote_params)
    @v1_quote.buyer = @current_buyer
    if @v1_quote.address.blank?
      @v1_quote.address = request.remote_ip
    end
    if @v1_quote.save
      InstanoMailer.notification(@v1_quote).deliver_later
      render json: @v1_quote, status: :created
    else
      render json: @v1_quote.errors, status: :unprocessable_entity
    end
  end

  def show
    @v1_quote = V1::Quote.find(params[:id])
    # forbidden if quote doesn't belong to buyer
    if @v1_quote.buyer != @current_buyer
      render json: {error: 'does not belong to you'}, status: :forbidden
    else
      render json: @v1_quote
    end
  end

  # PATCH/PUT /v1/buyers/quotes/1
  # PATCH/PUT /v1/buyers/quotes/1.json
  def update
    @v1_quote = V1::Quote.find(params[:id])
    # forbidden if quote doesn't belong to buyer
    if @v1_quote.buyer != @current_buyer
      render json: {error: 'does not belong to you'}, status: :forbidden
    elsif @v1_quote.update(quote_params)
      render json: @v1_quote, status: :ok
    else
      render json: @v1_quote.errors, status: :unprocessable_entity
    end
  end

private
  def quote_params
    params.require(:quote).permit(:product_id, :latitude, :longitude, :address, :status)
  end
end

class V1::BuyersController < V1::ApiBaseController
  before_filter :authorize_buyer!, :except => [:exists, :create, :sign_in, :sellers]

  # GET /v1/buyers
  # GET /v1/buyers.json
  def show
    render json: @current_buyer
  end

  # POST /v1/buyers
  # POST /v1/buyers.json
  def create
    @current_buyer = V1::Buyer.new(buyer_params)

    if @current_buyer.save
      associate_device
      render json: @current_buyer, status: :created
    else
      render json: @current_buyer.errors, status: :unprocessable_entity
    end
  end

  def exists
    render json: { exists: V1::Buyer.exists?(:phone => params.require(:phone)) }
  end

  def sign_in
    @current_buyer = V1::Buyer.find_by(api_key: params.require(:sign_in)[:api_key])
    if @current_buyer.nil?
      render json: { error: "incorrect api_key" }, status: :not_acceptable
    else
      associate_device
      render json: @current_buyer, status: :ok
    end
  end

  # PATCH/PUT /v1/buyers
  # PATCH/PUT /v1/buyers.json
  def update
    if @current_buyer.update(buyer_params)
      render json: @current_buyer, status: :ok
    else
      render json: @current_buyer.errors, status: :unprocessable_entity
    end
  end

  # GET /v1/sellers
  # GET /v1/sellers.json
  def sellers_index
    @v1_sellers = V1::Seller.where("status = ? OR status = ? OR status = ?",
                                   V1::Seller.statuses[:unverified],
                                   V1::Seller.statuses[:verified],
                                   V1::Seller.statuses[:deal_provider])
    render json: @v1_sellers
  end

  # GET /v1/sellers/1
  # GET /v1/sellers/1.json
  def sellers_show
    @v1_seller = V1::Seller.find(params[:id])
    render json: @v1_seller
  end

  # GET /v1/deals
  # GET /v1/deals.json
  def deals_index
    @v1_deals = V1::Deal.all
    render json: @v1_deals
  end

  # GET /v1/deals/1
  # GET /v1/deals/1.json
  def deals_show
    @v1_deal = V1::Deal.find(params[:id])
    render json: @v1_deal
  end

  # GET /v1/quotations
  # GET /v1/quotations.json
  def quotations
    # TODO: optimize
    @v1_quotations = V1::Quotation.where(quote_id: V1::Quote.select(:id).where(buyer_id: @current_buyer.id))
    render json: @v1_quotations
  end

  # GET /v1/quotes
  # GET /v1/quotes.json
  def quotes
    @v1_quotes_for_buyer = V1::Quote.where(buyer_id: @current_buyer.id)
    render json: @v1_quotes_for_buyer
  end

  # POST /v1/quotes
  # POST /v1/quotes.json
  def quotes_create
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

  # PATCH/PUT /v1/quotes/1
  # PATCH/PUT /v1/quotes/1.json
  def quotes_update
    @v1_quote = V1::Quote.find(params[:id])
#     forbidden if quote doesn't belong to buyer
    if @v1_quote.buyer != @current_buyer
      render json: { error: "quote does not belong to you" }, status: :forbidden
    elsif @v1_quote.update(quote_params)
      render json: @v1_quote, status: :ok
    else
      render json: @v1_quote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/quotations/1
  # PATCH/PUT /v1/quotations/1.json
  def quotations_update
    @v1_quotation = V1::Quotation.find(params[:id])

    if @v1_quotation.nil?
      render json: { error: "no quotation with id" }, status: :unprocessable_entity
    elsif @v1_quotation.quote.buyer != @current_buyer
      render json: { error: "quotation is not for you" }, status: :forbidden
    elsif @v1_quotation.update(quotation_params)
      render json: @v1_quotation, status: :ok
    else
      render json: @v1_quotation.errors, status: :unprocessable_entity
    end
  end

protected
  # for non-signed in users, just use the IP. be sure to override this method in respective controllers
  # rails admin controller already overrides this
  def current_user
    if current_buyer
      "buyer:(#{@current_buyer.id})#{@current_buyer.name}"
    else
      super
    end
  end

private
  def quotation_params
    params.require(:quotation).permit(:status)
  end

  def buyer_params
    params.require(:buyer).permit(:name, :phone)
  end

  def quote_params
    params.require(:quote).permit(:search_string, :brands, :price_range, :product_category,
                                  :latitude, :longitude, :address)
  end

  def associate_device
    @current_device.buyer = @current_buyer
    @current_device.save
  end

  def authorize_buyer!
    if current_buyer.nil?
      render json: { error: "no buyer associated"}, status: :forbidden
    end
  end

  def current_buyer
    unless @current_buyer
      @current_buyer = @current_device.buyer if current_device
    end
    return @current_buyer
  end
end

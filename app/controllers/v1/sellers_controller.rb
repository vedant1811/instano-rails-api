class V1::SellersController < V1::ApiBaseController
  before_filter :authorize_seller!, :except => [:exists, :create, :sign_in]

  def exists
    render json: { exists: V1::Seller.exists?(:email => params.require(:email)) }
  end

  def sign_in
    begin
      @current_seller = V1::Seller.find_by(:email => authenticate_params.require(:email))
      if @current_seller && @current_seller.authenticate(authenticate_params.require(:password))
        associate_device
        render json: @current_seller, root: "seller"
      else
        render json: { sign_in: "incorrect credentials" }, status: :not_acceptable
      end
    rescue ActionController::ParameterMissing => e
      render json: e, status: :unprocessable_entity
    end
  end

  # POST /v1/sellers
  # POST /v1/sellers.json
  def create
    @current_seller = V1::Seller.new(seller_params)
    @current_seller.status = "verified"

    if @current_seller.save
      @current_seller.assign_categories(params)
      associate_device
      render json: @current_seller.reload
    else
      render json: @current_seller.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/sellers
  # PATCH/PUT /v1/sellers.json
  def update
    if @current_seller.update(seller_params)
      @current_seller.assign_categories(params)
      render json: @current_seller.reload
    else
      render json: @current_seller.errors, status: :unprocessable_entity
    end
  end

  # POST /v1/quotations
  # POST /v1/quotations.json
  def quotations_create
    @v1_quotation = V1::Quotation.new(quotation_params)
    @v1_quotation.seller = @current_seller

    if @v1_quotation.save
      render json: @v1_quotation, status: :created
    else
      render json: @v1_quotation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/quotations/1
  # PATCH/PUT /v1/quotations/1.json
  def quotations_update
    @v1_quotation = V1::Quotation.find(params[:id])

    if @v1_quotation.seller != @current_seller
      render json: { error: "quotation does not belong to you" }, status: :forbidden
    elsif @v1_quotation.update(quotation_params)
      render json: @v1_quotation, status: :ok
    else
      render json: @v1_quotation.errors, status: :unprocessable_entity
    end
  end

  # GET /v1/quotes
  # GET /v1/quotes.json
  def quotes
    @v1_quotes_for_seller = V1::Quote.with_seller_id(@current_seller.id)
    render json: @v1_quotes_for_seller
  end

protected
  # for non-signed in users, just use the IP. be sure to override this method in respective controllers
  # rails admin controller already overrides this
  def current_user
    if current_seller
      "seller:(#{@current_seller.id})#{@current_seller.name_of_shop}"
    else
      super
    end
  end

private
  def quotation_params
    params.require(:quotation).permit(:name_of_product, :price, :description, :quote_id, :status)
  end

  def seller_params
    params.require(:seller).permit(:name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone, :email, :password)
  end

  def authenticate_params
    params.require(:sign_in).permit(:email, :password)
  end

  def associate_device
    @current_device.seller = @current_seller
    @current_device.save
  end

  def authorize_seller!
    if current_seller.nil?
      render json: { error: "no seller associated"}, status: :forbidden
    end
  end

  # sets @current_seller unless it is already set and returns it
  def current_seller
    unless @current_seller
      @current_seller = @current_device.seller if current_device
    end
    return @current_seller
  end
end

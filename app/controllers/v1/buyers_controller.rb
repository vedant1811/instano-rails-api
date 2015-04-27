class V1::BuyersController < V1::ApiBaseController
  before_filter :authorize_buyer!, :only => [:show, :update]

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

  # GET /v1/buyers
  # GET /v1/buyers.json
  def show
    render json: @current_buyer
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

  def associate_device
    @current_device.buyer = @current_buyer
    @current_device.save
  end
end

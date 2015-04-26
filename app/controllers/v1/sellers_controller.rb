class V1::SellersController < V1::ApiBaseController
  before_filter :authorize_seller!, :only => [:update]
  before_filter :authorize_buyer!, :only => [:index, :show]

  # GET /v1/buyers/sellers
  # GET /v1/buyers/sellers.json
  def index
    @v1_sellers = V1::Seller.where("status = ? OR status = ? OR status = ?",
                                   V1::Seller.statuses[:unverified],
                                   V1::Seller.statuses[:verified],
                                   V1::Seller.statuses[:deal_provider])
    render json: @v1_sellers
  end

  def show
    @v1_seller = V1::Seller.find(params[:id])
    render json: @v1_seller
  end

  def exists
    render json: { exists: V1::Seller.exists?(:email => params.require(:email)) }
  end

  def sign_in
    @current_seller = V1::Seller.find_by(:email => authenticate_params.require(:email))
    if @current_seller && @current_seller.authenticate(authenticate_params.require(:password))
      associate_device
      render json: @current_seller
    else
      render json: { sign_in: "incorrect credentials" }, status: :not_acceptable
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
end

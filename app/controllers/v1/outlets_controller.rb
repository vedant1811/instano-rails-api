class V1::OutletsController < V1::ApiBaseController
  before_filter :authorize_seller!, :only => [:update]
  before_filter :authorize_buyer!, :only => [:index, :show]

  def index
    product_id = params[:p]
    category_name = params[:category_name]
    lat = params.fetch(:lat, request.location.latitude)
    long = params.fetch(:long, request.location.longitude)

    if product_id
      @v1_outlets = V1::Outlet.visible # select verified
                        .joins(:brands).where(v1_brands: { brand_name_id: V1::Product.where(id: product_id).select(:brand_name_id) }) # that match brand_name
                        .where.not(id: V1::Quotation.where(product_id: product_id).select(:seller_id)) # and have no quotations for said product
                        .near([lat, long])
                        .distinct
                        .select(:id, :updated_at)
    elsif category_name
      # TODO: make into 1 query
      @v1_outlets = V1::CategoryName.find_by(name: category_name).outlets
                        .visible
                        .near([lat, long], 20, :km)
                        .distinct
    end
    
    @v1_outlets.each do |outlet|
      puts outlet.distance_from([lat, long])
    end    

    render json: @v1_outlets, only: [:id, :updated_at]
  end

  def show
    @v1_outlet = V1::Outlet.find(params[:id])
    render json: @v1_outlet
  end

  def update

  end
end

class V1::OutletsController < V1::ApiBaseController
  before_filter :authorize_seller!, :only => [:update]
  before_filter :authorize_buyer!, :only => [:index, :show]

  def index
    # code here
  end

  def show
    @v1_outlet = V1::Outlet.find(params[:id])
    render json: @v1_outlet
  end

  def update

  end
end

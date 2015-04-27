class V1::DealsController < V1::ApiBaseController
  before_filter :authorize_seller!, :only => [:create, :update]
  before_filter :authorize_buyer!, :only => [:index]

  # GET /v1/deals
  # GET /v1/deals.json
  def index
    @v1_deals = V1::Deal.all
    render json: @v1_deals
  end

  def create
    @v1_deal = V1::Deal.new(deal_params)
    @v1_deal.seller = @current_seller
    if @v1_deal.save
      render json: @v1_deal, status: :created
    else
      render json: @v1_deal.errors, status: :unprocessable_entity
    end
  end

  # GET /v1/deals/1
  # GET /v1/deals/1.json
  def show
    @v1_deal = V1::Deal.find(params[:id])
    render json: @v1_deal
  end

  def update
    @v1_deal = V1::Deal.find(params[:id])
    if @v1_deal.seller != @current_seller
      render json: { error: "does not belong to you" }, status: :forbidden
    elsif @v1_deal.update(deal_params)
      render json: @v1_deal, status: :ok
    else
      render json: @v1_deal.errors, status: :unprocessable_entity
    end
  end
private
  def deal_params
    params.require(:deal).permit(:product_id, :heading, :subheading, :expires_at)
  end
end

class V1::QuotationsController < V1::ApiBaseController
  before_filter :authorize_seller!, :only => [:create, :update]
  before_filter :authorize_buyer!, :only => [:index]

  def index
    @v1_quotations = V1::Quotation.where(product_id: params[:p])
    render json: @v1_quotations
  end

  # POST /v1/quotations
  # POST /v1/quotations.json
  def create
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
  def update
    @v1_quotation = V1::Quotation.find(params[:id])

    if @v1_quotation.seller != @current_seller
      render json: { error: "does not belong to you" }, status: :forbidden
    elsif @v1_quotation.update(quotation_params)
      render json: @v1_quotation, status: :ok
    else
      render json: @v1_quotation.errors, status: :unprocessable_entity
    end
  end

private
  def quotation_params
    params.require(:quotation).permit(:name_of_product, :price, :description, :quote_id, :status)
  end
end

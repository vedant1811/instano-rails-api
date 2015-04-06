class V1::ProductsController < V1::ApiBaseController

  # POST /v1/products
  # POST /v1/products.json
  def create
    status = "scraped"
    @v1_product = V1::Product.new(product_params)
    if category_params[:category_name]
      category_name = V1::CategoryName.find_or_create_by_name(category_params[:category_name], case_sensitive: false)
      @v1_product.category_name = category_name
    else
      status = "on_hold"
    end
    if category_params[:brand_name]
      brand_name = V1::BrandName.find_or_create_by_name(category_params[:brand_name], case_sensitive: false)
      @v1_product.brand_name = brand_name
    else
      status = "on_hold"
    end

    @v1_product.device = @current_device
    @v1_product.status = status
    if @v1_product.save
      head :created
    else
      render json: @v1_product.errors, status: :unprocessable_entity
    end
  end

private
  def category_params
    params.require(:product).permit(:brand_name, :category_name)
  end
  def product_params
    params.require(:product).permit(:name, :image, :mrp, :their_price, :url)
  end
end

class V1::BrandsCategoriesController < V1::ApiBaseController
  # does only device auth

  def index
    render json: V1::CategoryName.all, root: "categories"
  end

end

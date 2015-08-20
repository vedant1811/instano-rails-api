class V1::BrandsCategoriesController < V1::ApiBaseController
  # does only device auth

  def index
    @v1_categories = V1::CategoryName.all
    if params[:short]
      render json: @v1_categories, except: [:brands]
    else
      render json: @v1_categories, root: "categories"
    end
  end

end

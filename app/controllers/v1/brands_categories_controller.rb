class V1::BrandsCategoriesController < ApplicationController

  def index
  end

  def add_category
    params.require(:category, :brands => [])

    brands = []

    params[:brands].each do |brand|
      brands << V1::Brand.find_or_create_by(name: brand)
    end

    category = V1::Category.find_or_create_by(name: params[:category])

    category.brands = brands
    render json: category.save

  end

  def add_brand # to a category. brands should not exist if they do not belong to a category
  end

  def assign_to_seller # :category and :brands already exist in the database.
    params.require(:category, :seller_id).permit(:brands => [])
  end

end

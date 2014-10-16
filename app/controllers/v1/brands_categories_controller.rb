class V1::BrandsCategoriesController < ApplicationController

  def index
    render json: V1::Category.all
  end

  def add_category
    params.require(:category)
    params.require(:brands)

    category = V1::Category.find_or_create_by(name: params[:category])

    params[:brands].each do |brand_name|
      category.brands << V1::Brand.find_or_create_by(name: brand_name) unless category.brands.exists?(name: brand_name)
    end

    render json: category

  end

  def assign_to_seller # :category and :brands already exist in the database.
    params.require(:categories)
    params.permit(:categories => []).permit(:name, :brands => [])
    params.require(:seller_id)

    seller = V1::Seller.find(params[:seller_id])

    params[:categories].each do |category|
      name = category[:name]
      category[:brands].each do |brand|
        seller_category = V1::SellerCategory.new
        seller_category.brand = V1::Brand.find_by(name: brand)
        seller_category.category = V1::Category.find_by(name: name)
        seller_category.seller = seller
        seller_category.save
      end
    end

    render json: seller.seller_categories

  end

end

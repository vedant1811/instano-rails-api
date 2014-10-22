class V1::BrandsCategoriesController < ApplicationController

  def index
    render json: V1::CategoryName.all
  end

  def add_category
    params.require(:category)
    params.require(:brands)

    category_name = V1::CategoryName.find_or_create_by(name: params[:category])

    params[:brands].each do |brand_name|
      category_name.brand_names.create(name: brand_name)
    end

    render json: category_name

  end

  def assign_to_seller # :category and :brands already exist in the database.
    params.require(:categories)
    params.permit(:categories => []).permit(:name, :brands => [])
    params.require(:seller_id)

    seller = V1::Seller.find(params[:seller_id])

    seller.categories.eager_load(:category_name).where(v1_category_names: {name: "xyz"})

    params[:categories].each do |c|
      category_name = c[:name]

      # get the category if it already exists for the seller
      category_relation = seller.categories.eager_load(:category_name)
          .where(v1_category_names: {name: category_name})
      if category_relation.empty?
        category = V1::Category.new
        category.category_name = V1::CategoryName.find_by(name: category_name)
        category.seller = seller
        category.save
      else
        category = category_relation.first
      end
      c[:brands].each do |b|
        begin
          category.brand_names << V1::BrandName.find_by(name: b)
        rescue ActiveRecord::RecordInvalid
          # skip it. May happen if brand is already added to the particular category
        end
      end
    end

    render json: seller.categories

  end

end

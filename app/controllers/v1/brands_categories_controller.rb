class V1::BrandsCategoriesController < ApplicationController

  def index
    render json: V1::Category.where(id: V1::BrandCategory.where(seller_id: nil).select(:category_id).distinct)
  end

  def add_category
    params.require(:category)
    params.require(:brands)

    category = V1::Category.find_or_create_by(name: params[:category])

    params[:brands].each do |brand_name|
      begin
        category.brands << V1::Brand.find_or_create_by(name: brand_name) unless category.brands.exists?(name: brand_name)
      rescue ActiveRecord::RecordInvalid
      end
    end

    render json: category

  end

  def assign_to_seller # :category and :brands already exist in the database.
    params.require(:categories)
    params.permit(:categories => []).permit(:name, :brands => [])
    params.require(:seller_id)

    seller = V1::Seller.find(params[:seller_id])

    params[:categories].each do |c|
      category_name = c[:name]
      if seller.categories.exists?(name: category_name)
        category = seller.categories.find_by(name: category_name)
      else
        if V1::Category.exists?(name: category_name)
          category = V1::Category.new(name: category_name)
        else
          next # category is invalid
        end
      end
      seller.categories << category
      c[:brands].each do |b|
        begin
          category.brands << V1::Brand.find_by(name: b)
        rescue ActiveRecord::RecordInvalid, ActiveRecord::AssociationTypeMismatch
        end
      end
    end

    render json: seller.categories

  end

end

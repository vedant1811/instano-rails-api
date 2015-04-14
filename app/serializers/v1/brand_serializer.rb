class V1::BrandSerializer < ActiveModel::Serializer
  attributes :name, :category

  def name
    object.brand_name.name
  end

  def category
    object.brand_name.category_name.name
  end
end

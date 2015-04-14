class V1::BrandNameSerializer < ActiveModel::Serializer
  attributes :name, :category

  def category
    object.category_name.name
  end
end

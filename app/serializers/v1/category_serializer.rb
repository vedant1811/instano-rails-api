class V1::CategorySerializer < ActiveModel::Serializer
  attributes :category, :brands

  def category
    object.category_name.name
  end

  def brands
    brand_names = []
    object.brands.each do |brand|
      brand_names << brand.brand_name[:name]
    end
    brand_names
  end
end

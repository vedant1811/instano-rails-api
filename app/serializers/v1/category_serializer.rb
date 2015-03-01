class V1::CategorySerializer < ActiveModel::Serializer
  attributes :category, :brands

  def category
    object.category_name.name unless object.category_name.nil?
  end

  def brands
    brand_names = []
    object.brands.each do |brand|
      brand_names << brand.brand_name[:name] unless brand.brand_name.nil?
    end unless object.brands.nil?
    brand_names
  end
end

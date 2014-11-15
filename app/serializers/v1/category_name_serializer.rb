class V1::CategoryNameSerializer < ActiveModel::Serializer
  attributes :category, :variants, :brands

  def category
    object.name
  end

  def brands
    brand_names = []
    object.brand_names.each do |brand|
      brand_names << brand[:name]
    end
    brand_names
  end
end

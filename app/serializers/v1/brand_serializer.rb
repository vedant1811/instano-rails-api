class V1::BrandSerializer < ActiveModel::Serializer
  attributes :name, :category

  def name
    if object.brand_name
      object.brand_name.name
    else
      nil
    end
  end

  def category
    if object.brand_name && object.brand_name.category_name
      object.brand_name.category_name.name
    else
      nil
    end
  end
end

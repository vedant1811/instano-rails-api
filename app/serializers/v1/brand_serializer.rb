class V1::BrandSerializer < ActiveModel::Serializer
  has_one :brand_name, :class_name => 'V1::BrandName'
end

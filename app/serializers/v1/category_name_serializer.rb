class V1::CategoryNameSerializer < ActiveModel::Serializer
  attributes :name
  has_many :brand_names, :class_name => 'V1::BrandName'
end

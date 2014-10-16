class V1::CategorySerializer < ActiveModel::Serializer
  attributes :name

  has_many :brands, :class_name => 'V1::Brand', through: :brand_categories
end

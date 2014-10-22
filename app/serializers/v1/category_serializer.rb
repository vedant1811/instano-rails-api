class V1::CategorySerializer < ActiveModel::Serializer
  has_one :category_name, :class_name => 'V1::CategoryName'
  has_many :brands, :class_name => 'V1::Brand'
end

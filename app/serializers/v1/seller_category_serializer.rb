class V1::SellerCategorySerializer < ActiveModel::Serializer
  has_one :brand, :class_name => 'V1::Brand'
  has_one :category, :class_name => 'V1::Category'
end

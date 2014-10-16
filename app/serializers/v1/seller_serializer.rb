class V1::SellerSerializer < ActiveModel::Serializer
  attributes :id, :name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone, :seller_categories
  has_many :seller_categories, :class_name => 'V1::SellerCategory'
end

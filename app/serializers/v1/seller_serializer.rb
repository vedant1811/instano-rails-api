class V1::SellerSerializer < ActiveModel::Serializer
  attributes :id, :name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone
  has_many :brand_categories, :class_name => 'V1::BrandCategory'
  has_many :categories, :class_name => 'V1::Category', through: :brand_categories
end

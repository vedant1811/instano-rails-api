class V1::SellerSerializer < ActiveModel::Serializer
  attributes :id, :name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone, :email, :rating, :status
  has_many :categories, :class_name => 'V1::Category'
end

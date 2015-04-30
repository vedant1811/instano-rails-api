class V1::SellerSerializer < ActiveModel::Serializer
  attributes :id, :name_of_shop, :phone, :email, :rating, :status, :outlets
  has_many :brands
end

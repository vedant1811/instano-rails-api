class V1::DealSerializer < ActiveModel::Serializer
  has_one :product
  attributes :id, :product, :heading, :subheading, :expires_at, :seller_id, :updated_at
end

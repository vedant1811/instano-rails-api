class V1::DealSerializer < ActiveModel::Serializer
  attributes :id, :heading, :subheading, :expires_at, :seller_id
end

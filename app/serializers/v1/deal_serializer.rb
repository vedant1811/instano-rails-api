class V1::DealSerializer < ActiveModel::Serializer
  attributes :id, :heading, :subheading, :updated_at, :expires_at, :seller_id
end

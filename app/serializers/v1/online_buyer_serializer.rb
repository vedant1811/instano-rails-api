class V1::OnlineBuyerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :url, :message
end

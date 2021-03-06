class V1::SellerSerializer < ActiveModel::Serializer
  attributes :id, :name_of_shop, :image, :outlets, :description, :updated_at
  has_many :brands

  def image
    object.image.url(:card) if object.image.exists?
  end
end

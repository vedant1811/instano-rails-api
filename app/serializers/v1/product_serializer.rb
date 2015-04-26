class V1::ProductSerializer < ActiveModel::Serializer
  has_one :brand_name
  attributes :id, :name, :brand_name, :image, :features

  def image
    object.image.url(:medium)
  end
end

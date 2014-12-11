class V1::Brand < ActiveRecord::Base
  belongs_to :brand_name, :class_name => 'V1::BrandName', inverse_of: :brand
  belongs_to :category, :class_name => 'V1::Category', inverse_of: :brand

  validates :category, :uniqueness => {:scope => [:brand_name, :category]}
end

class V1::Category < ActiveRecord::Base
  has_many :brand_categories, :class_name => 'V1::BrandCategory'
  has_many :brands, :class_name => 'V1::Brand', through: :brand_categories
end

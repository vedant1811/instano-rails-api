class V1::Category < ActiveRecord::Base
  has_many :brands_categories, :class_name => 'V1::BrandCategory'
  has_many :brands, :class_name => 'V1::Brand', through: :brands_categories, :class_name => 'V1::BrandCategory'
end

class V1::Brand < ActiveRecord::Base
  has_many :brand_categories, :class_name => 'V1::BrandCategory'
  has_many :categories, :class_name => 'V1::Category', through: :brand_categories
end

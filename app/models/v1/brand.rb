class V1::Brand < ActiveRecord::Base
  has_many :brands_categories, :class_name => 'V1::BrandCategory'
  has_many :categories, :class_name => 'V1::Category', through: :brands_categories, :class_name => 'V1::BrandCategory'
end

class V1::Category < ActiveRecord::Base

  belongs_to :category_name, :class_name => 'V1::CategoryName'

  has_many :brand_categories, :class_name => 'V1::BrandCategory'
  has_many :brands, :class_name => 'V1::Brand', through: :brand_categories

  validates :name, :uniqueness: true
end

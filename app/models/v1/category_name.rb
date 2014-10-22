class V1::CategoryName < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category'
  has_many :brand_names, :class_name => 'V1::BrandName'

  validates :name, :uniqueness => true
end

class V1::Brand < ActiveRecord::Base
  belongs_to :brand_name, :class_name => 'V1::BrandName'
  belongs_to :category, :class_name => 'V1::Category'

  validates :category, :uniqueness => {:scope => [:brand_name, :category]}
end

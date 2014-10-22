class V1::BrandName < ActiveRecord::Base
  has_many :brands, :class_name => 'V1::Brand'
  belongs_to :category_name, :class_name => 'V1::CategoryName'

  validates :category_name, :uniqueness => {:scope => [:category_name, :name]}
end


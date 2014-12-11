class V1::BrandName < ActiveRecord::Base
  has_many :brands, :class_name => 'V1::Brand', dependent: :delete_all, inverse_of: :brand_name
  belongs_to :category_name, :class_name => 'V1::CategoryName', inverse_of: :brand_name

  validates :category_name, :uniqueness => {:scope => [:category_name, :name]}
  validates :category_name, presence: true
end


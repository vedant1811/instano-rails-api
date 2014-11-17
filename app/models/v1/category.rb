class V1::Category < ActiveRecord::Base
  belongs_to :category_name, :class_name => 'V1::CategoryName'
  belongs_to :seller, :class_name => 'V1::Seller'
  has_many :brands, :class_name => 'V1::Brand', dependent: :delete_all
  has_many :brand_names, :class_name => 'V1::BrandName', through: :brands

  validates :seller, :uniqueness => {:scope => [:category_name, :seller]}
end
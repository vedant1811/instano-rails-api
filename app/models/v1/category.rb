class V1::Category < ActiveRecord::Base
  belongs_to :category_name, :class_name => 'V1::CategoryName', inverse_of: :category
  belongs_to :seller, :class_name => 'V1::Seller', inverse_of: :category
  has_many :brands, :class_name => 'V1::Brand', dependent: :delete_all, inverse_of: :category
  has_many :brand_names, :class_name => 'V1::BrandName', through: :brands, inverse_of: :category

  validates :seller, :uniqueness => {:scope => [:category_name, :seller]}
end

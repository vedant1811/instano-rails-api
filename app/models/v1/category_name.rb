class V1::CategoryName < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category', dependent: :delete_all
  has_many :brand_names, :class_name => 'V1::BrandName', dependent: :delete_all, inverse_of: :category_name

  validates :name, :uniqueness => true

  # TODO: add validation for variants uniqueness and lower case
end

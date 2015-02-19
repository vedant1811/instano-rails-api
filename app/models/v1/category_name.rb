class V1::CategoryName < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category', dependent: :destroy
  has_many :brand_names, :class_name => 'V1::BrandName', dependent: :destroy, inverse_of: :category_name
  accepts_nested_attributes_for :brand_names, allow_destroy: true

  validates :name, :uniqueness => true
  validates :name, presence: true

  # TODO: add validation for variants uniqueness and lower case

  has_paper_trail
end

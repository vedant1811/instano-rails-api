class V1::CategoryName < ActiveRecord::Base
  has_many :brand_names, :class_name => 'V1::BrandName', dependent: :destroy, inverse_of: :category_name
  has_many :products, :class_name => 'V1::Product', through: :brand_names, dependent: :nullify
#   accepts_nested_attributes_for :brand_names, allow_destroy: true

  validates :name, :uniqueness => {:case_sensitive => false}
  validates :name, presence: true

  # TODO: add validation for variants uniqueness and lower case

  has_paper_trail
end

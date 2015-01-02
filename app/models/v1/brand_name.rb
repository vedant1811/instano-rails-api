class V1::BrandName < ActiveRecord::Base
  has_many :brands, :class_name => 'V1::Brand', dependent: :destroy_all
  belongs_to :category_name, :class_name => 'V1::CategoryName', dependent: :delete

  validates :category_name, :uniqueness => {:scope => [:category_name, :name]}
  validates :category_name, presence: true
  validates :name, presence: true
end


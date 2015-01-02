class V1::Category < ActiveRecord::Base
  belongs_to :category_name, :class_name => 'V1::CategoryName', dependent: :delete
  belongs_to :seller, :class_name => 'V1::Seller', dependent: :delete
  has_many :brands, :class_name => 'V1::Brand', dependent: :delete_all
  has_many :brand_names, :class_name => 'V1::BrandName', through: :brands

  validates :seller, :uniqueness => {:scope => [:category_name, :seller]}
  validates :category_name, presence: true
  validates :seller, presence: true

  def title
    if category_name
      category_name.name
    else
      self.destroy # hack, in case we have such categories
    end
  end
end

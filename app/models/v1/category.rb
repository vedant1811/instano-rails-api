class V1::Category < ActiveRecord::Base
  belongs_to :category_name, :class_name => 'V1::CategoryName'
  belongs_to :seller, :class_name => 'V1::Seller'
  has_many :brands, :class_name => 'V1::Brand', dependent: :destroy
  has_many :brand_names, :class_name => 'V1::BrandName', through: :brands

  validates :seller, :uniqueness => {:scope => [:category_name, :seller]}
  validates :category_name, presence: true
  validates :seller, presence: true

  has_paper_trail

  def title
    if category_name
      category_name.name
    else
      "ERROR-fixme id=#{id}"
    end
  end
end

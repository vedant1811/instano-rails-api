class V1::Brand < ActiveRecord::Base
  belongs_to :brand_name, :class_name => 'V1::BrandName'
  belongs_to :category, :class_name => 'V1::Category'

  validates :category, :uniqueness => {:scope => [:brand_name, :category]}
  validates :brand_name, presence: true
  validates :category, presence: true

  has_paper_trail

  def title
    if brand_name
      brand_name.name
    else
      "ERROR-fixme id=#{id}"
    end
  end
end

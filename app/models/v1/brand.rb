class V1::Brand < ActiveRecord::Base
  belongs_to :brand_name, :class_name => 'V1::BrandName'
  belongs_to :seller, :class_name => 'V1::Seller'

  validates :brand_name, presence: true
  # there is database limitation but rails_admin is unable to create for new sellers if this line is present:
#   validates :seller, presence: true

  has_paper_trail

  def title
    if brand_name && brand_name.name && brand_name.category_name && brand_name.category_name.name
      "#{brand_name.name} in #{brand_name.category_name.name}"
    else
      "ERROR-fixme id=#{id}"
    end
  end
end

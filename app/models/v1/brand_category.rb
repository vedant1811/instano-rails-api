class V1::BrandCategory < ActiveRecord::Base
  belongs_to :brand, :class_name => 'V1::Brand'
  belongs_to :category, :class_name => 'V1::Category'
  belongs_to :seller, :class_name => 'V1::Seller'

  validates :category, :uniqueness => {:scope => [:brand, :category, :seller]}

end

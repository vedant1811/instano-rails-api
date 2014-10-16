class V1::SellerCategory < ActiveRecord::Base
  belongs_to :brand, :class_name => 'V1::Brand'
  belongs_to :category, :class_name => 'V1::Category'
  belongs_to :seller, :class_name => 'V1::Seller'

  validates :seller_id, :uniqueness => {:scope => [:brand_id, :category_id, :seller_id]}
end

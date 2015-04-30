class V1::Outlet < ActiveRecord::Base
  belongs_to :seller, :class_name => 'V1::Seller'

  validates :seller, presence: true
  validates :address, presence: true

  has_paper_trail
end

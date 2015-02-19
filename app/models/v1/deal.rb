class V1::Deal < ActiveRecord::Base
  belongs_to :seller, :class_name => 'V1::Seller'
  validates :heading, presence: true
  validates :expires_at, presence: true
  validates :seller, presence: true

  has_paper_trail
end

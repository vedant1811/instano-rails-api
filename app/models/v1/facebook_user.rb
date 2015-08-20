class V1::FacebookUser < ActiveRecord::Base

  has_one :buyer, :class_name => 'V1::Buyer'

  validates :user_id, presence: true, uniqueness: true
  validates :name, presence: true

  has_paper_trail
end

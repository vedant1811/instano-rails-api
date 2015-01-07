class V1::Deal < ActiveRecord::Base
  belongs_to :seller, :class_name => 'V1::Seller', dependent: :delete
  validates :heading, presence: true
  validates :expires_at, presence: true
  validates :seller, presence: true
end

class V1::Buyer < ActiveRecord::Base

  has_many :quotes, :class_name => 'V1::Quote', dependent: :destroy
  has_many :devices, :class_name => 'V1::Device', dependent: :nullify
  belongs_to :facebook_user, :class_name => 'V1::FacebookUser'

  accepts_nested_attributes_for :facebook_user

  validates :facebook_user, presence: true # not done at db level

  has_paper_trail
end

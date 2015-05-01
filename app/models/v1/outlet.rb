class V1::Outlet < ActiveRecord::Base
  belongs_to :seller, :class_name => 'V1::Seller'

  validates :seller, presence: true
  validates :address, presence: true

  # important! do NOT reorder entries
  enum status: [
           # invisible in app
           :removed,
           :inactive,
           # visible in app
           :unverified,
           :verified,
           :deal_provider
       ]

  has_paper_trail
end

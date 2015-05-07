class V1::Outlet < ActiveRecord::Base
  # TODO:
  # after_validation :geocode, if: ->(obj){ obj.latitude.nil? }

  belongs_to :seller, :class_name => 'V1::Seller'

  validates :seller, presence: true
  validates :address, presence: true

  reverse_geocoded_by :latitude, :longitude

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

  rails_admin do
    configure :status do
      searchable false
    end
  end

end

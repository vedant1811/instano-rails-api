class V1::Booking < ActiveRecord::Base

  belongs_to :quote, :class_name => 'V1::Quote'
  belongs_to :outlet, :class_name => 'V1::Outlet'

  has_paper_trail

  validates :price, presence: true
  validates :quote, presence: true
  validates :outlet, presence: true

  enum status: [ :neither, :cancelled, :accepted ] # :neither implies active, or expired based on expires_at


  rails_admin do
    configure :status do
      searchable false
    end
  end
end

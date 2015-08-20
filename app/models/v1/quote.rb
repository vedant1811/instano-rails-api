class V1::Quote < ActiveRecord::Base
  after_save :notify

  belongs_to :buyer, :class_name => 'V1::Buyer'
  belongs_to :product, :class_name => 'V1::Product'

  enum status: [ :active, :expired, :closed ] # unused for now

  validates :product, presence: true # TODO:, uniqueness: { scope: [:product, :buyer] }
  validates :buyer, presence: true

  has_paper_trail

  rails_admin do
    configure :status do
      searchable false
    end
    list do
      field :product
      field :buyer
      field :address
      field :status, :enum
      sort_by :created_at
      items_per_page 100
    end
    show do
      field :product
      field :buyer
      field :address
      field :status, :enum
      field :latitude
      field :longitude
    end
    edit do
      field :product
      field :buyer
      field :address
      field :status, :enum
      field :latitude
      field :longitude
    end
  end

private
  def notify
    require 'modules/gcm_notifier'
    GcmNotifier.quote_updated(self)
  end
end

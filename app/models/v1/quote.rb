class V1::Quote < ActiveRecord::Base
  after_save :notify

  belongs_to :buyer, :class_name => 'V1::Buyer'
  belongs_to :product, :class_name => 'V1::Product'

  enum status: [ :active, :expired, :closed ]

  validates :product, presence: true

  has_paper_trail

  scope :with_seller_id, -> (*seller_ids) { where('seller_ids @> ARRAY[:seller_ids]', seller_ids: seller_ids) }

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

  # for active admin
  def ids_raw
    self.seller_ids.join(',') unless self.seller_ids.nil?
  end

  # for active admin
  def ids_raw=(values)
    self.seller_ids = []
    self.seller_ids=values.split(',')
  end

private
  def notify
    require 'modules/gcm_notifier'
    GcmNotifier.quote_updated(self)
  end
end

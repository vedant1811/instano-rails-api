class V1::Quote < ActiveRecord::Base

  belongs_to :buyer, :class_name => 'V1::Buyer', dependent: :destroy

  enum status: [ :active, :expired, :closed ]

  validates :buyer_id, presence: true
  validates :search_string, presence: true
  validates :brands, presence: true
  validates :price_range, presence: true
  validates :product_category, presence: true # do not access this. will be removed
  validates :seller_ids, presence: true

  scope :with_seller_id, -> (*seller_ids) { where('seller_ids @> ARRAY[:seller_ids]', seller_ids: seller_ids) }

  rails_admin do
    configure :status do
      searchable false
    end
    list do
      field :search_string
      field :buyer
      field :address
      field :brands
      field :price_range
      field :seller_ids
      field :status, :enum
      sort_by :created_at
      items_per_page 100
    end
    show do
      field :search_string
      field :buyer
      field :address
      field :brands
      field :price_range
      field :status, :enum
      field :seller_ids, :pg_int_array
      field :latitude
      field :longitude
    end
    edit do
      field :search_string
      field :buyer
      field :address
      field :brands
      field :price_range
      field :status, :enum
      field :seller_ids, :pg_int_array
      field :latitude
      field :longitude
    end
  end

  # for active admin
  def ids_raw
    self.seller_ids.join(",") unless self.seller_ids.nil?
  end

  # for active admin
  def ids_raw=(values)
    self.seller_ids = []
    self.seller_ids=values.split(",")
  end

  after_create :new_quote

private
  def new_quote
      InstanoMailer.delay.new_quote(self)
  end
end

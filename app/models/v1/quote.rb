class V1::Quote < ActiveRecord::Base
  enum status: [ :active, :expired, :closed ]

  validates :buyer_id, presence: true
  validates :search_string, presence: true
  validates :brands, presence: true
  validates :price_range, presence: true
  validates :product_category, presence: true # do not access this. will be removed
  validates :seller_ids, presence: true

  scope :with_seller_id, -> (*seller_ids) { where('seller_ids @> ARRAY[:seller_ids]', seller_ids: seller_ids) }

  def ids_raw
    self.seller_ids.join(",") unless self.seller_ids.nil?
  end

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

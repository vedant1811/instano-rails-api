class V1::Quote < ActiveRecord::Base
  enum status: [ :active, :expired, :closed ]

  scope :with_seller_id, -> (*seller_ids) { where('seller_ids @> ARRAY[:seller_ids]', seller_ids: seller_ids) }

  after_create :new_quote

private
  def new_quote
      InstanoMailer.delay.new_quote(self)
  end
end

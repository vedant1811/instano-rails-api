class V1::Quotation < ActiveRecord::Base
  enum status: [ :unread, :read, :expired, :accepted ]
  validates :name_of_product, presence: true
  validates :price, presence: true
  validates :quote_id, presence: true
  validates :seller_id, presence: true

  rails_admin do
    configure :status do
      searchable false
    end
  end
end

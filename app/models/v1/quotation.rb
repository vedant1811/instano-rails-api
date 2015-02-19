class V1::Quotation < ActiveRecord::Base
  belongs_to :seller, :class_name => 'V1::Seller'
  belongs_to :quote, :class_name => 'V1::Quote'

  enum status: [ :unread, :read, :expired, :accepted ]
  validates :name_of_product, presence: true
  validates :price, presence: true
  validates :quote_id, presence: true
  validates :seller_id, presence: true

  has_paper_trail

  rails_admin do
    configure :status do
      searchable false
    end
  end
end

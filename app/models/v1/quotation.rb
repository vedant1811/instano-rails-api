class V1::Quotation < ActiveRecord::Base
  after_save :notify

  belongs_to :seller, :class_name => 'V1::Seller'
  belongs_to :quote, :class_name => 'V1::Quote'

  enum status: [ :unread, :read, :expired, :accepted, :cancelled ]
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

private
  def notify
    require 'modules/gcm_notifier'
    GcmNotifier.quotation_updated(self)
  end
end

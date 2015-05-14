class V1::Booking < ActiveRecord::Base
  before_save :guess_price

  belongs_to :buyer, :class_name => 'V1::Buyer'
  belongs_to :quotation, :class_name => 'V1::Quotation'
  belongs_to :deal, :class_name => 'V1::Deal'

  has_paper_trail

  validates :buyer, presence: true
  validate :either_deal_or_quotation

  enum status: [ :neither, :cancelled, :accepted ] # :neither implies active, or expired based on expires_at


  rails_admin do
    configure :status do
      searchable false
    end

    configure :price do
      help 'if empty, will take the same price as quotation'
    end
  end

  private
  def either_deal_or_quotation
    if (deal && quotation) || (!deal && !quotation)
      errors.add(:base, 'select either deal or quotation')
    end
  end

  def guess_price
    unless price
      if quotation
        self.price = quotation.price
        # TODO:
      # elsif deal
      #   price = deal
      end
    end
  end
end

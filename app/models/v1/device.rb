class V1::Device < ActiveRecord::Base
  belongs_to :buyer, :class_name => 'V1::Buyer'
  belongs_to :seller, :class_name => 'V1::Seller'
#   has_many :products, :class_name => 'V1::Product', dependent: :nullify

  validates :gcm_registration_id, :uniqueness => true

  enum gcm_status: [
    :unverified,
    :verified,
    :error
  ]

  has_paper_trail

  before_create :reset_session

  # care: do not forget to save
  # TODO: reset sessions in case session id is really old
  def reset_session
    begin
      self.session_id = SecureRandom.hex
    end while self.class.exists?(session_id: session_id)
    puts self.session_id
  end
end

class V1::Buyer < ActiveRecord::Base
  before_create :generate_api_key

  has_many :quotes, :class_name => 'V1::Quote', dependent: :destroy
  has_many :devices, :class_name => 'V1::Device', dependent: :nullify

  validates :phone, uniqueness: true
  validates :phone, presence: true
  validates :name, presence: true

  has_paper_trail

private
  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
end

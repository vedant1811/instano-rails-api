class V1::Buyer < ActiveRecord::Base
  before_create :generate_api_key

  validates :phone, :uniqueness => true
  validates :name, presence: true
  validates :phone, presence: true

private

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end

end

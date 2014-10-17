class V1::Seller < ActiveRecord::Base
  has_many :brand_categories, :class_name => 'V1::BrandCategory'
  has_many :categories, :class_name => 'V1::Category', through: :brand_categories

  before_create :generate_api_key

  has_secure_password

private

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end

end

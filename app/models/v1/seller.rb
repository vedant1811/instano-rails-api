class V1::Seller < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
# 	  :rememberable,
	 :confirmable, :lockable

  enum product_category: [ :unspecified, :others,
                   :refrigerators,
                   :TVs,
                   :'washing machnies',
                   :'microwave ovens',
                   :'home theatres',
                   :'air coolers',
                   :mobiles ]

  before_create :generate_api_key

private

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end

end

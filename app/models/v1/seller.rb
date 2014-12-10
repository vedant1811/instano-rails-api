class V1::Seller < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category', dependent: :delete_all
  has_many :category_names, :class_name => 'V1::CategoryName', through: :categories

  validates :email, :uniqueness => true

  before_create :generate_api_key

  after_create :send_welcome_email

  has_secure_password

  def self.authenticate(email, password)
    seller = find_by_email(email)
    if seller && seller.authenticate(password)
      seller
    else
      nil
    end
  end

  def assign_categories(params)
    params.require(:seller).require(:categories)
    params.require(:seller).permit(:categories => []).permit(:name, :brands => [])

    self.categories.clear

    params[:seller][:categories].each do |c|

      if c[:brands].nil? || c[:brands].empty?
        next # skip the category if it has no brands associated with it
      end

      category_name = c[:name]
      category = V1::Category.new
      category.category_name = V1::CategoryName.find_by(name: category_name)
      category.seller = self
      category.save
      c[:brands].each do |b|
        begin
          category.brand_names << V1::BrandName.find_by(name: b)
        rescue ActiveRecord::RecordInvalid
          # skip it. May happen if brand is already added to the particular category
        end
      end
    end
  end

private
  def send_welcome_email
      InstanoMailer.delay.welcome_email(self)
  end

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
end

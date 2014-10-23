class V1::Seller < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category', dependent: :delete_all
  has_many :category_names, :class_name => 'V1::CategoryName', through: :categories

  validates :email, :uniqueness => true

  before_create :generate_api_key

  has_secure_password

  def assign_categories(params)
    begin
      params.require(:seller).require(:categories)
      params.require(:seller).permit(:categories => []).permit(:name, :brands => [])

      self.categories.clear

      params[:seller][:categories].each do |c|
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
    rescue ActionController::ParameterMissing # no categories key present in params
      # do nothing
    end
  end

private

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end

end

class V1::Seller < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category', dependent: :destroy
  has_many :deals, :class_name => 'V1::Deal', dependent: :destroy
  has_many :quotations, :class_name => 'V1::Quotation', dependent: :destroy
  has_many :category_names, :class_name => 'V1::CategoryName', through: :categories
  has_many :devices, :class_name => 'V1::Device', dependent: :nullify

  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :rating, presence: true
  validates :email, presence: true, uniqueness: true

  # important! do NOT reorder entries
  enum status: [
    # invisible in app
    :removed,
    :inactive,
    # visible in app
    :unverified,
    :verified,
    :deal_provider
  ]

  before_create :generate_api_key
  after_create :send_welcome_email
  has_secure_password
  has_paper_trail

  def title
    "#{name_of_shop} (#{id})"
  end

  rails_admin do
    configure :status do
      searchable false
    end
    list do
      field :name_of_shop
      field :category_names
      field :status, :enum
      field :phone
      field :address
      field :email
      sort_by :created_at
      items_per_page 100
    end
    show do
      field :id
      field :status, :enum
      field :name_of_shop
      field :name_of_seller
      field :address
      field :category_names
      field :phone
      field :email
      field :created_at
      field :updated_at
    end
    edit do # both edit and create
      field :name_of_shop
      field :name_of_seller
      field :status
      field :email
      # TODO: fix: (also see: https://github.com/sferik/rails_admin/issues/2150)
      field :password
      field :password_confirmation
      field :address
      field :latitude
      field :longitude
      field :phone
      field :categories do
        label "edit brands"
        help "Use only to edit brands. Do not add/remove categories"
      end
      field :category_names do
        help "add/remove categories. then update. then add brands"
      end
    end
  end

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

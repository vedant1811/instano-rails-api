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
  after_save :guess_brands_categories, :notify
  has_secure_password
  has_paper_trail

  def title
    "#{name_of_shop} (#{id})"
  end

  rails_admin do
    configure :status do
      searchable false
    end
    clone_config do
      custom_method :shallow_clone
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

      category_name = c[:name]
      category = V1::Category.new
      category.category_name = V1::CategoryName.find_by(name: category_name)
      category.seller = self
      category.save

      if c[:brands].nil? || c[:brands].empty?
        next
      end

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
  def shallow_clone
    self.dup.tap do |seller|
      seller.password = Rails.application.secrets.placeholder_password
      seller.password_confirmation = seller.password
      seller.email = "#{self.email}2"
    end
  end

  def guess_brands_categories
    return unless self.categories.empty?
    same_sellers = V1::Seller.where(name_of_shop: self.name_of_shop)
    parent_seller = nil
    same_sellers.each do |seller|
      unless seller.categories.empty?
        parent_seller = seller
        break
      end
    end

    # now assign parent_seller's categories to self only if parent_seller is not nil:
    parent_seller.categories.each do |parent_category|
      self.categories.create!(category_name: parent_category.category_name,
                              brands: parent_category.brands)
    end if parent_seller
  end

  # TODO: notify (and handle the case) if status is changed from visible to invisible in app
  def notify
    return unless verified? || unverified? || deal_provider?
    require 'modules/gcm_notifier'
    GcmNotifier.seller_updated(self)
  end

  def send_welcome_email
    InstanoMailer.welcome_email(self).deliver_later if verified?
  end

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
end

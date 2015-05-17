class V1::Seller < ActiveRecord::Base
  before_create :generate_api_key, :sanitize_file_name
  after_create :send_welcome_email
  after_save :notify

  has_attached_file :image, # paperclip options:
                    :preserve_files => "false",
                    :styles => {:card => '427x240>'},
                    :url => "/:rails_env/#{table_name}/images/:style/:filename",
                    :default_url => ":url/missing.png",
                    :path => ":url",
                    :storage => :s3,
                    :s3_headers => { 'Expires' => 1.year.from_now.httpdate },
                    :s3_credentials => "#{Rails.root}/config/secrets.yml",
                    :bucket => 'instano',
                    :s3_storage_class => :reduced_redundancy

  has_many :deals, :class_name => 'V1::Deal', dependent: :destroy
  has_many :quotations, :class_name => 'V1::Quotation', dependent: :destroy
  has_many :brands, :class_name => 'V1::Brand', dependent: :destroy
  has_many :brand_names, :class_name => 'V1::BrandName', through: :brands
  has_many :category_names, :class_name => 'V1::CategoryName', through: :brand_names
  has_many :devices, :class_name => 'V1::Device', dependent: :nullify
  has_many :outlets, :class_name => 'V1::Outlet'

  accepts_nested_attributes_for :brands

  validates :rating, presence: true
  validates :email, presence: true, uniqueness: true

  # paperclip:
  validates_with AttachmentFileNameValidator, :attributes => :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentContentTypeValidator, :attributes => :image, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 2.megabytes

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

  scope :visible, -> { where('status >= ?', V1::Seller.statuses[:unverified]) }

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
      field :image
      field :description
      field :brand_names
      field :status, :enum
      field :phone
      field :email
      sort_by :created_at
      items_per_page 100
    end
    show do
      field :id
      field :status, :enum
      field :name_of_shop
      field :image
      field :description
      field :outlets
      field :brand_names
      field :phone
      field :email
      field :created_at
      field :updated_at
    end
    edit do # both edit and create
      field :name_of_shop
      field :image
      field :description, :ck_editor
      field :status
      field :email
      # TODO: fix: (also see: https://github.com/sferik/rails_admin/issues/2150)
      field :password
      field :password_confirmation
      field :phone
      field :brands
      field :brand_names do
        label "edit brands"
        help "Use only to edit brands. Do not add/remove categories"
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
    begin
      puts 'starting assign_categories'
      puts params.inspect
      permitted = params.require(:seller).permit(brands: [:name, :category])
      puts permitted.inspect

      self.brands.clear

      permitted[:brands].each do |c|
        next if c[:name].nil? || c[:category].nil?

        category_name = V1::CategoryName.find_by(name: c[:category])
        if category_name
          brand_name = V1::BrandName.find_by(name: c[:name], category_name: category_name)
          self.brand_names << brand_name if brand_name
        end
      end
    rescue ActionController::ParameterMissing => e
      logger.error e
    end
  end

private
  def sanitize_file_name
    if image_file_name
      extension = File.extname(image_file_name).downcase
      self.image.instance_write(:file_name, "#{self.name.parameterize('_')}#{extension}")
    end
  end

  def shallow_clone
    self.dup.tap do |seller|
      seller.password = Rails.application.secrets.placeholder_password
      seller.password_confirmation = seller.password
      seller.email = "#{self.email}2"
    end
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

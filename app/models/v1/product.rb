class V1::Product < ActiveRecord::Base
  before_create :sanitize_file_name

  has_attached_file :image, # paperclip options:
        :preserve_files => "false",
        :styles => { :medium => '300x300>', :thumb => '100x100>'},
        :url => "/:rails_env/#{table_name}/images/:style/:filename",
        :default_url => ":url/missing.png",
        :path => ":url",
        :storage => :s3,
        :s3_headers => { 'Expires' => 1.year.from_now.httpdate },
        :s3_credentials => "#{Rails.root}/config/secrets.yml",
        :bucket => 'instano',
        :s3_storage_class => :reduced_redundancy

  belongs_to :brand_name, :class_name => 'V1::BrandName'
  belongs_to :device, :class_name => 'V1::Device'
  has_many :deals, :class_name => 'V1::Deal'
  has_many :quotes, :class_name => 'V1::Quote'
  has_many :quotations, :class_name => 'V1::Quotation'

  validates :name, uniqueness: {case_sensitive: false}, presence: true
  validates :their_price, presence: true
  validates :url, presence: true

  # paperclip:
  validates_with AttachmentFileNameValidator, :attributes => :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentContentTypeValidator, :attributes => :image, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 2.megabytes

  # important! do NOT reorder entries
  enum status: [
    # invisible in app
    :deleted,
    :on_hold,
    # visible in app
    :scraped,
    :from_quotation,
    :verified
    ]

  rails_admin do
    configure :status do
      searchable false
    end
  end

  private
  def sanitize_file_name
    if image_file_name
      extension = File.extname(image_file_name).downcase
      self.image.instance_write(:file_name, "#{self.name.parameterize('_')}#{extension}")
    end
  end
end

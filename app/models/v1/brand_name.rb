class V1::BrandName < ActiveRecord::Base
  has_many :brands, :class_name => 'V1::Brand', dependent: :destroy
  has_many :products, :class_name => 'V1::Product', dependent: :nullify
  belongs_to :category_name, :class_name => 'V1::CategoryName'

  validates :category_name, :uniqueness => {:scope => [:category_name, :name]}
  validates :category_name, presence: true
  validates :name, :uniqueness => {:case_sensitive => false}
  validates :name, presence: true

  has_paper_trail

  def self.find_or_create_by_name(*args)
    options = args.extract_options!
    options[:name] = args[0] if args[0].is_a?(String)
    case_sensitive = options.delete(:case_sensitive)
    conditions = case_sensitive ? ['name = ?', options[:name]] :
    ['UPPER(name) = ?', options[:name].upcase]
    where(conditions).first || create(options)
  end
end

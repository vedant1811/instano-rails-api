class V1::CategoryName < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category', dependent: :destroy
  has_many :brand_names, :class_name => 'V1::BrandName', dependent: :destroy, inverse_of: :category_name
  has_many :products, :class_name => 'V1::Product', dependent: :nullify
  accepts_nested_attributes_for :brand_names, allow_destroy: true

  validates :name, :uniqueness => {:case_sensitive => false}
  validates :name, presence: true

  # TODO: add validation for variants uniqueness and lower case

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

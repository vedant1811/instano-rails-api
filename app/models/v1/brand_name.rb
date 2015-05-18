class V1::BrandName < ActiveRecord::Base
  has_many :brands, :class_name => 'V1::Brand', dependent: :destroy
  has_many :sellers, :class_name => 'V1::Seller', through: :brands
  has_many :products, :class_name => 'V1::Product', dependent: :nullify
  belongs_to :category_name, :class_name => 'V1::CategoryName'

  validates :category_name, presence: true
  validates :name, presence: true
  validates :name, :uniqueness => {:scope => [:category_name, :name]}

  has_paper_trail

  rails_admin do
    object_label_method do
      :title
    end
  end

  def title
    if self.name && self.category_name && self.category_name.name
      "#{self.name} in #{self.category_name.name}"
    else
      "FIXME"
    end
  end
end

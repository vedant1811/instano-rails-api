class V1::BrandName < ActiveRecord::Base
  has_many :brands, :class_name => 'V1::Brand', dependent: :destroy
  has_many :products, :class_name => 'V1::Product', dependent: :nullify
  belongs_to :category_name, :class_name => 'V1::CategoryName'

  validates :category_name, :uniqueness => {:scope => [:category_name, :name]}
  validates :category_name, presence: true
  validates :name, presence: true

  has_paper_trail

  rails_admin do
    object_label_method do
      :title
    end
  end

  def title
    "#{self.name} in #{self.category_name.name}"
  end
end

class V1::Brand < ActiveRecord::Base
  belongs_to :brand_name, :class_name => 'V1::BrandName', dependent: :delete
  belongs_to :category, :class_name => 'V1::Category', dependent: :delete

  validates :category, :uniqueness => {:scope => [:brand_name, :category]}
  validates :brand_name, presence: true
  validates :category, presence: true

  def title
    if brand_name
      brand_name.name
    else
      self.destroy # hack, in case we have such brands
    end
  end
end

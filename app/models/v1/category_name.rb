class V1::CategoryName < ActiveRecord::Base
  has_many :categories, :class_name => 'V1::Category'
end

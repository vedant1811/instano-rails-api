class DropV1Categories < ActiveRecord::Migration
  class V1::Brand < ActiveRecord::Base
    belongs_to :seller, :class_name => 'V1::Seller'
    belongs_to :category, :class_name => 'V1::Category'
  end

  class V1::Category < ActiveRecord::Base
    belongs_to :seller, :class_name => 'V1::Seller'
  end

  def up
    add_column :v1_brands, :seller_id, :integer, default: 0, null: false

    V1::Brand.reset_column_information
    V1::Brand.all.each do |brand|
      if brand.category && brand.category.seller
        brand.seller = brand.category.seller
        brand.save!
      else
        brand.destroy!
      end
    end

    change_column_default :v1_brands, :seller_id, nil
    drop_table :v1_categories
  end
end

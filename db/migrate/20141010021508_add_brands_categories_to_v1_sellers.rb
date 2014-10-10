class AddBrandsCategoriesToV1Sellers < ActiveRecord::Migration
  def change
    remove_column :v1_sellers, :product_categories, :integer, default: [0], null: false, array: true
    add_reference :v1_sellers, :brands_categories, :class_name => 'V1::BrandCategory', index: true
  end
end

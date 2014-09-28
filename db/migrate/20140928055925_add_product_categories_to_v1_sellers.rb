class AddProductCategoriesToV1Sellers < ActiveRecord::Migration
  def change
    add_column :v1_sellers, :product_categories, :integer, array: true, default: [0], null: false
  end
end

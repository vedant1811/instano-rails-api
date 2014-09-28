class AddProductCategoryToV1Quotes < ActiveRecord::Migration
  def change
    add_column :v1_quotes, :product_category, :integer, default: 0, null: false
  end
end

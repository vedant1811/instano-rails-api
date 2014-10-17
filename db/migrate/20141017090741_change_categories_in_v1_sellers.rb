class ChangeCategoriesInV1Sellers < ActiveRecord::Migration
  def change
    remove_column :v1_sellers, :brand_categories_id, :integer
  end
end

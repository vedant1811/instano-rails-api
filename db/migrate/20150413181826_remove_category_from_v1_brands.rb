class RemoveCategoryFromV1Brands < ActiveRecord::Migration
  def change
    remove_column :v1_brands, :category_id, :integer
  end
end

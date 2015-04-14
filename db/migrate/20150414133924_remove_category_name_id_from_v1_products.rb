class RemoveCategoryNameIdFromV1Products < ActiveRecord::Migration
  def change
    remove_column :v1_products, :category_name_id, :integer
  end
end

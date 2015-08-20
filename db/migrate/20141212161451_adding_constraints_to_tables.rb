class AddingConstraintsToTables < ActiveRecord::Migration
  def change
    change_column :v1_brand_names, :name, :string, unique: true
    change_column :v1_category_names, :name, :string, unique: true
    change_column :v1_sellers, :email, :string, unique: true
  end
end

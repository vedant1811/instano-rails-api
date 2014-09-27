class ChangeNullableWithoutDefaultsFromV1Sellers < ActiveRecord::Migration
  def change
    change_column :v1_sellers, :name_of_seller, :string, null: false
    change_column :v1_sellers, :name_of_shop, :string, null: false
    change_column :v1_sellers, :email, :string, null: false
    change_column :v1_sellers, :address, :text, null: false
    change_column :v1_sellers, :phone, :string, null: false
  end
end

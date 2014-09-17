class AddNamesToV1Sellers < ActiveRecord::Migration
  def change
    add_column :v1_sellers, :name_of_shop, :string
    add_column :v1_sellers, :name_of_seller, :string
  end
end

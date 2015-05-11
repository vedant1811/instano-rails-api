class AddDescriptionToV1Sellers < ActiveRecord::Migration
  def change
    add_column :v1_sellers, :description, :text
  end
end

class ChangeNullableFromV1Sellers < ActiveRecord::Migration
  def change
    change_column :v1_sellers, :latitude, :decimal, precision: 10, scale: 6, null: false, default: -1000
    change_column :v1_sellers, :longitude, :decimal, precision: 10, scale: 6, null: false, default: -1000
  end
end

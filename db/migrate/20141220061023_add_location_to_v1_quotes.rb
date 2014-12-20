class AddLocationToV1Quotes < ActiveRecord::Migration
  def change
    add_column :v1_quotes, :address, :string
    add_column :v1_quotes, :latitude, :decimal, precision: 10, scale: 6
    add_column :v1_quotes, :longitude, :decimal, precision: 10, scale: 6
  end
end

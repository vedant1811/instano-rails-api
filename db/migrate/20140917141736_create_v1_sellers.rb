class CreateV1Sellers < ActiveRecord::Migration
  def change
    create_table :v1_sellers do |t|
      t.string :api_key
      t.text :address
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :phone
      t.integer :rating

      t.timestamps
    end
  end
end

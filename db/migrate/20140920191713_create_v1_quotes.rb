class CreateV1Quotes < ActiveRecord::Migration
  def change
    create_table :v1_quotes do |t|
      t.integer :buyer_id
      t.string :search_string
      t.string :brands
      t.string :price_range

      t.timestamps
    end
  end
end

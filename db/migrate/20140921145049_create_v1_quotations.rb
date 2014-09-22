class CreateV1Quotations < ActiveRecord::Migration
  def change
    create_table :v1_quotations do |t|
      t.string :name_of_product
      t.integer :price
      t.text :description
      t.integer :seller_id

      t.timestamps
    end
  end
end

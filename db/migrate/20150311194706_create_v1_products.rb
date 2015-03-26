class CreateV1Products < ActiveRecord::Migration
  def change
    create_table :v1_products do |t|
      t.string :name, null: false, unique: true
      t.integer :category_name_id
      t.integer :brand_name_id
      t.attachment :image
      t.integer :status, null: false, default: 0
      t.integer :device_id, unique: true

      t.timestamps
    end
  end
end

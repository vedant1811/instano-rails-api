class CreateV1Deals < ActiveRecord::Migration
  def change
    create_table :v1_deals do |t|
      t.string :heading, null: false
      t.string :subheading
      t.datetime :expires_at, null: false
      t.integer :seller_id, null: false

      t.timestamps
    end
  end
end

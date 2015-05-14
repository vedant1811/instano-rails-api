class CreateV1Bookings < ActiveRecord::Migration
  def change
    create_table :v1_bookings do |t|
      t.integer :status, null: false, default: 0
      t.integer :price, null: false
      t.integer :quote_id, null: false
      t.integer :outlet_id, null: false
      t.timestamp :expires_at, null: false, default: 2.days.from_now # i.e. 2 days after created at

      t.timestamps null: false
    end
  end
end

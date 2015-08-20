class CreateV1Bookings < ActiveRecord::Migration
  def change
    create_table :v1_bookings do |t|
      t.integer :status, null: false, default: 0
      t.integer :price, null: false
      t.integer :buyer_id, null: false
      # either and only either should be present
      t.integer :quotation_id
      t.integer :deal_id

      t.timestamp :expires_at, null: false, default: 2.days.from_now # i.e. 2 days after created at

      t.timestamps null: false
    end
  end
end

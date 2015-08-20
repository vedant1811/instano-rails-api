class CreateV1OnlineBuyers < ActiveRecord::Migration
  def change
    create_table :v1_online_buyers do |t|
      t.string :name
      t.string :phone
      t.string :url
      t.string :message

      t.timestamps
    end
  end
end

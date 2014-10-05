class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :v1_visitors do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end

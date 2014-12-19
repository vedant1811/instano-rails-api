class AddProfileToV1Buyers < ActiveRecord::Migration
  def change
    add_column :v1_buyers, :name, :string
    add_column :v1_buyers, :phone, :string, unique: true
  end
end

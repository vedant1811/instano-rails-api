class AddBuyerAndSellerIdsToV1Devices < ActiveRecord::Migration
  def change
    add_column :v1_devices, :buyer_id, :integer, null: true
    add_column :v1_devices, :seller_id, :integer, null: true
  end
end

class AddSellerIdsToV1Quotes < ActiveRecord::Migration
  def change
    add_column :v1_quotes, :seller_ids, :integer, array: true, default: [0], null: false # just to fill previous data
    change_column :v1_quotes, :seller_ids, :integer, array: true, null: false
  end
end

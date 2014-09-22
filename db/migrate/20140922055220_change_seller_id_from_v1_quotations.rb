class ChangeSellerIdFromV1Quotations < ActiveRecord::Migration
  def change
    rename_column :v1_quotations, :seller_id, :seller_api_key
    change_column :v1_quotations, :seller_api_key, :string
  end
end

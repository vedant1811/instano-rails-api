class ChangeSellerApiKeyFromV1Quotations < ActiveRecord::Migration
  def change
    remove_column :v1_quotations, :seller_api_key
    add_column :v1_quotations, :seller_id, :integer
  end
end

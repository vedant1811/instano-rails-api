class AddStatusToV1Sellers < ActiveRecord::Migration
  def change
    add_column :v1_sellers, :status, :integer, default: 0
  end
end

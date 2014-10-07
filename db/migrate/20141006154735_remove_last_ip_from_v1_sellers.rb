class RemoveLastIpFromV1Sellers < ActiveRecord::Migration
  def change
    remove_column :v1_sellers, :last_sign_in_ip
  end
end

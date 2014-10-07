class AddAuthenticationTokenToV1Sellers < ActiveRecord::Migration
  def change
    add_column :v1_sellers, :authentication_token, :string
    add_index :v1_sellers, :authentication_token
  end
end

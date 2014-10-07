class AddPasswordToV1Sellers < ActiveRecord::Migration
  def change
    add_column :v1_sellers, :password_digest, :string
  end
end

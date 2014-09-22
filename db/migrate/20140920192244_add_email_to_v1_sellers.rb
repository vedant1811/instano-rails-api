class AddEmailToV1Sellers < ActiveRecord::Migration
  def change
    add_column :v1_sellers, :email, :string
  end
end

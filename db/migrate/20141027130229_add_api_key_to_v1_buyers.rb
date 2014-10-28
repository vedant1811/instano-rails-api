class AddApiKeyToV1Buyers < ActiveRecord::Migration
  def change
    add_column :v1_buyers, :api_key, :string
  end
end

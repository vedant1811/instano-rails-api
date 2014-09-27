class ChangeNullableFromV1Quotes < ActiveRecord::Migration
  def change
    change_column :v1_quotes, :buyer_id, :integer, null: false
    change_column :v1_quotes, :search_string, :string, null: false
    change_column :v1_quotes, :brands, :string, null: false, default: ''
    change_column :v1_quotes, :price_range, :string, null: false, default: ''
  end
end

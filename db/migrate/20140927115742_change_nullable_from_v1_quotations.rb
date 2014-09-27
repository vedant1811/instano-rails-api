class ChangeNullableFromV1Quotations < ActiveRecord::Migration
  def change
    change_column :v1_quotations, :name_of_product, :string, null: false
    change_column :v1_quotations, :price, :integer, null: false
    change_column :v1_quotations, :description, :text, null: false, default: ''
    change_column :v1_quotations, :quote_id, :integer, null: false
    change_column :v1_quotations, :seller_id, :integer, null: false
  end
end

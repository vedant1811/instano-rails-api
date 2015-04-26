class RelateToV1Products < ActiveRecord::Migration
  def change
    add_column :v1_deals, :product_id, :integer, null: true

    # now quotations are only related to products:
    add_column :v1_quotations, :product_id, :integer, default: 0, null: false
    remove_column :v1_quotations, :name_of_product, :string
    remove_column :v1_quotations, :quote_id, :integer
    # first we make existing product_ids 0, then prevent future records from being 0
    change_column_default :v1_quotations, :product_id, nil

    # now quotes are only related to products. It is just to keep track of searches
    add_column :v1_quotes, :product_id, :integer, default: 0, null: false
    # first we make existing product_ids 0, then prevent future records from being 0
    change_column_default :v1_quotes, :product_id, nil
    remove_column :v1_quotes, :brands, :string
    remove_column :v1_quotes, :price_range, :string
    remove_column :v1_quotes, :product_category, :string
    remove_column :v1_quotes, :search_string, :string
    remove_column :v1_quotes, :seller_ids, :integer, array: true
  end
end

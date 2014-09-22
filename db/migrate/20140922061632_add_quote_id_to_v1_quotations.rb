class AddQuoteIdToV1Quotations < ActiveRecord::Migration
  def change
    add_column :v1_quotations, :quote_id, :integer
  end
end

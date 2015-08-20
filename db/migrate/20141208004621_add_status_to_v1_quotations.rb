class AddStatusToV1Quotations < ActiveRecord::Migration
  def change
    add_column :v1_quotations, :status, :integer, default: 0
  end
end

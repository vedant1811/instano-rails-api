class AddStatusToV1Quotes < ActiveRecord::Migration
  def change
    add_column :v1_quotes, :status, :integer, default: 0
  end
end

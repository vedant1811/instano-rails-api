class ChangeV1Products < ActiveRecord::Migration
  def change
    add_index :v1_products, :name, unique: true
    add_column :v1_products, :mrp, :integer, null: true

    # first add a default value so that existing rows get them (and migration does not fail)
    add_column :v1_products, :their_price, :integer, default: 0, null: false
    add_column :v1_products, :url, :string, default: 0, null: false

    # now remove the default so that new rows will have to have a value
    change_column_default :v1_products, :their_price, nil
    change_column_default :v1_products, :url, nil
  end
end

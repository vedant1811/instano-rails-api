class AddFeaturesToV1Products < ActiveRecord::Migration
  def change
    add_column :v1_products, :features, :text
  end
end

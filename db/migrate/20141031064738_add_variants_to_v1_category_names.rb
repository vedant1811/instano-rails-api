class AddVariantsToV1CategoryNames < ActiveRecord::Migration
  def change
    add_column :v1_category_names, :variants, :string, array: true
  end
end

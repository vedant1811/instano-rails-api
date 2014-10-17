class CreateV1CategoryNames < ActiveRecord::Migration
  def change
    create_table :v1_category_names do |t|
      t.string :name
    end
    remove_column :v1_categories, :name, :string
    belongs_to :v1_categories, :category_name, :class_name => 'V1::Category'
  end
end

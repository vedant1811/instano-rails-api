class CreateV1BrandsCategories < ActiveRecord::Migration
  def change
    create_table :v1_categories do |t|
      t.string :name
    end

    create_table :v1_brands do |t|
      t.string :name
    end

    create_table :v1_brands_categories, id: false do |t|
      t.belongs_to :brand, :class_name => 'V1::Brand'
      t.belongs_to :category, :class_name => 'V1::Category'
      t.belongs_to :seller, :class_name => 'V1::Seller'
    end
  end
end

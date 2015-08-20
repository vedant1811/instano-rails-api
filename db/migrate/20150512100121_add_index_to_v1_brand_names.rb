class AddIndexToV1BrandNames < ActiveRecord::Migration
  def up

    # find all models and group them on keys which should be common
    grouped = V1::Brand.all.group_by{|brand| [brand.seller_id, brand.brand_name_id] }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # to remove the first one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy!} # duplicates can now be destroyed
    end
    # now add the index
    add_index :v1_brands, [:seller_id, :brand_name_id], unique: true

    # find all models and group them on keys which should be common
    grouped = V1::BrandName.all.group_by{|brand_name| [brand_name.name, brand_name.category_name_id] }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # to remove the first one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy!} # duplicates can now be destroyed
    end
    # now add the index
    add_index :v1_brand_names, [:category_name_id, :name], unique: true
  end
end

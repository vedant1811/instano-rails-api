class ChangeNullableRatingFromV1Sellers < ActiveRecord::Migration
  def change
    change_column :v1_sellers, :rating, :integer, null: false, default: -1
  end
end

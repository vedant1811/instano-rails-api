class MakingNullableInV1Sellers < ActiveRecord::Migration
  def change
	  change_column_null :v1_sellers, :address, true
	  change_column_null :v1_sellers, :phone, true
	  change_column_null :v1_sellers, :name_of_shop, true
	  change_column_null :v1_sellers, :name_of_seller, true
  end
end

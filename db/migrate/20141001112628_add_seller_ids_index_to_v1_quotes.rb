class AddSellerIdsIndexToV1Quotes < ActiveRecord::Migration
  def change
    add_index  :v1_quotes, :seller_ids, using: 'gin'
  end
end

class RemoveIndexFromV1Sellers < ActiveRecord::Migration
  def change
    remove_index(:v1_sellers, :name => 'index_v1_sellers_on_email')
  end
end

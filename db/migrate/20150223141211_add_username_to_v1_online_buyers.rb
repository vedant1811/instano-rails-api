class AddUsernameToV1OnlineBuyers < ActiveRecord::Migration
  def change
    add_column :v1_online_buyers, :username, :string
  end
end

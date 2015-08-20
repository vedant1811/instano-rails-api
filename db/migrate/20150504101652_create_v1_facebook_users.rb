class CreateV1FacebookUsers < ActiveRecord::Migration
  def change
    create_table :v1_facebook_users do |t|
      t.string :user_id, null: false, unique: true
      t.string :name, null: false
      t.string :email
      t.boolean :verified # provided by the facebook API
      t.string :gender
      t.datetime :user_updated_at

      t.timestamps null: false
    end

    add_column :v1_buyers, :facebook_user_id, :integer
    remove_column :v1_buyers, :api_key, :string
  end
end

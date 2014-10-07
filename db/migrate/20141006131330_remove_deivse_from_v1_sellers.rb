class RemoveDeivseFromV1Sellers < ActiveRecord::Migration
  def change
    remove_column :v1_sellers, :encrypted_password
    remove_column :v1_sellers, :reset_password_token
    remove_column :v1_sellers, :reset_password_sent_at
    remove_column :v1_sellers, :remember_created_at
    remove_column :v1_sellers, :sign_in_count
    remove_column :v1_sellers, :current_sign_in_at
    remove_column :v1_sellers, :last_sign_in_at
    remove_column :v1_sellers, :current_sign_in_ip
    remove_column :v1_sellers, :last_sign_in_ip
    remove_column :v1_sellers, :confirmation_token
    remove_column :v1_sellers, :confirmed_at
    remove_column :v1_sellers, :confirmation_sent_at
    remove_column :v1_sellers, :unconfirmed_email
    remove_column :v1_sellers, :failed_attempts
    remove_column :v1_sellers, :locked_at

    remove_column :v1_sellers, :authentication_token
  end
end

class AddGcmToV1Devices < ActiveRecord::Migration
  def change
    add_column :v1_devices, :gcm_registration_id, :string, :null => false, :unique => true, :default => 'Illegal state'
    add_column :v1_devices, :session_id, :string, :unique => true
  end
end

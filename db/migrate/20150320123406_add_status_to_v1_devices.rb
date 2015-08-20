class AddStatusToV1Devices < ActiveRecord::Migration
  def change
    add_column :v1_devices, :gcm_status, :integer, default: 0
  end
end

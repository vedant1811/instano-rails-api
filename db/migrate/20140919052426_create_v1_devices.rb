class CreateV1Devices < ActiveRecord::Migration
  def change
    create_table :v1_devices do |t|

      t.timestamps
    end
  end
end

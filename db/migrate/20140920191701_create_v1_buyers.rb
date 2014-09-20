class CreateV1Buyers < ActiveRecord::Migration
  def change
    create_table :v1_buyers do |t|

      t.timestamps
    end
  end
end

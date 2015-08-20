class AddAttachmentImageToV1Sellers < ActiveRecord::Migration
  def self.up
    change_table :v1_sellers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :v1_sellers, :image
  end
end

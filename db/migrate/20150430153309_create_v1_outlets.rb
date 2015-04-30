class CreateV1Outlets < ActiveRecord::Migration
  class V1::Seller < ActiveRecord::Base
    has_many :outlets, :class_name => 'V1::Outlet'
  end

  class V1::Outlet < ActiveRecord::Base
    belongs_to :seller, :class_name => 'V1::Seller'
  end

  def up
    create_table :v1_outlets do |t|
      t.integer :seller_id, null: false
      t.string :address, null: false
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :seller_name
      t.string :phone
      t.integer :status, null: false, default: 0
    end

    V1::Outlet.reset_column_information
    V1::Seller.all.each do |seller|
      outlet = V1::Outlet.new
      outlet.seller = V1::Seller.where(name_of_shop: seller.name_of_shop).first
      if seller.address
        outlet.address = seller.address
        outlet.status = V1::Seller.statuses[seller.status]
      else
        outlet.address = 'FIXME!!!'
        # status will be set to 'removed' by default
      end
      outlet.latitude = seller.latitude if seller.latitude > -999 # since INVALID_COORDINATE is -1000
      outlet.longitude = seller.longitude if seller.longitude > -999 # since INVALID_COORDINATE is -1000
      outlet.seller_name = seller.name_of_seller
      # truncate the +91 if it is present:
      outlet.phone = ActionController::Base.helpers.number_to_phone(seller.phone.gsub(/^\+91/, ''))
      outlet.save!
    end # all outlets saved without error

    V1::Seller.reset_column_information

    V1::Seller.all.each do |seller|
      if seller.outlets.empty?
        seller.destroy!
      end
    end

    remove_column :v1_sellers, :address
    remove_column :v1_sellers, :latitude
    remove_column :v1_sellers, :longitude
    remove_column :v1_sellers, :name_of_seller
    # leaving status as is now. can be removed later
    # phone is being duplicated: seller.phone will be hidden from buyers, while outlet.phone will be visible

  end
end

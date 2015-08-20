ActiveAdmin.register V1::Seller do
  permit_params :name_of_shop, :name_of_seller, :latitude, :longitude, :address, :phone, :email, :password, :status

  index do
    selectable_column
    id_column
    column :name_of_shop
    column :name_of_seller
    column :status
    column :phone
    column :email
    column :address
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Seller Details" do
      f.input :status, as: :select, collection: V1::Seller.statuses.keys
      f.input :name_of_shop
      f.input :name_of_seller
      f.input :latitude
      f.input :longitude
      f.input :address
      f.input :phone
      f.input :email
      f.input :password
    end
    f.actions
  end
end

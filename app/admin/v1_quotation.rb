ActiveAdmin.register V1::Quotation do
permit_params :name_of_product, :price, :description, :seller_id, :quote_id, :status

  form do |f|
    f.inputs "Seller Details" do
      f.input :name_of_product
      f.input :price
      f.input :description
      f.input :seller_id
      f.input :quote_id
      f.input :status, as: :select, collection: V1::Quotation.statuses.keys
    end
    f.actions
  end

end

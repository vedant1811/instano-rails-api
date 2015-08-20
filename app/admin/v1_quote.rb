ActiveAdmin.register V1::Quote do
  permit_params :buyer_id, :search_string, :brands, :price_range,
      :latitude, :longitude, :address, :ids_raw


  form do |f|
    f.inputs "Quote Details" do
      f.input :buyer_id, :label => "buyer id"
      f.input :search_string
      f.input :brands
      f.input :price_range, :label => "price range (₹5,000 to ₹50,000)"
      f.input :latitude
      f.input :longitude
      f.input :address
      f.input :ids_raw, :as => :text, :label => "Seller Ids (, seprarated)"
      f.input :status, as: :select, collection: V1::Quote.statuses.keys
    end
    f.actions
  end

end

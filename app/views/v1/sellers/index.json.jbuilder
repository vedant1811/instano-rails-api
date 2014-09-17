json.array!(@v1_sellers) do |v1_seller|
  json.extract! v1_seller, :id, :api_key, :address, :latitude, :longitude, :phone, :rating
  json.url v1_seller_url(v1_seller, format: :json)
end

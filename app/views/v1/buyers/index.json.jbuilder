json.array!(@v1_buyers) do |v1_buyer|
  json.extract! v1_buyer, :id
  json.url v1_buyer_url(v1_buyer, format: :json)
end

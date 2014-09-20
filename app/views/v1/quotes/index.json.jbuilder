json.array!(@v1_quotes) do |v1_quote|
  json.extract! v1_quote, :id, :buyer_id, :search_string, :brands, :price_range
  json.url v1_quote_url(v1_quote, format: :json)
end

json.array!(@v1_quotations) do |v1_quotation|
  json.extract! v1_quotation, :id, :name_of_product, :price, :description, :seller_id
  json.url v1_quotation_url(v1_quotation, format: :json)
end

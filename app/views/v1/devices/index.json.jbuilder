json.array!(@v1_devices) do |v1_device|
  json.extract! v1_device, :id
  json.url v1_device_url(v1_device, format: :json)
end

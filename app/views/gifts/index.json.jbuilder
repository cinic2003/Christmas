json.array!(@gifts) do |gift|
  json.extract! gift, :id, :name, :giving, :who
  json.url gift_url(gift, format: :json)
end

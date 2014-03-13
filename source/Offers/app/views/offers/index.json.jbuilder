json.array!(@offers) do |offer|
  json.extract! offer, :id, :merchant_id, :title, :description, :url, :expires_at
  json.url offer_url(offer, format: :json)
end

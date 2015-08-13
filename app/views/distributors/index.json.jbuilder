json.array!(@distributors) do |distributor|
  json.extract! distributor, :id
  json.url distributor_url(distributor, format: :json)
end

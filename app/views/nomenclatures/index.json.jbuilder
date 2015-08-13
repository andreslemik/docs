json.array!(@nomenclatures) do |nomenclature|
  json.extract! nomenclature, :id
  json.url nomenclature_url(nomenclature, format: :json)
end

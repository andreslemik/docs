json.array!(@revises) do |revise|
  json.extract! revise, :id, :date_begin, :date_end, :memo, :distributor_id, :deleted_at
  json.url revise_url(revise, format: :json)
end

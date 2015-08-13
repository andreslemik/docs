json.array!(@new_messages) do |message|
  json.extract! message, :id
  json.url message_url(message, format: :json)
end
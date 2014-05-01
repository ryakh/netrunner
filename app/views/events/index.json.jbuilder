json.array!(@events) do |event|
  json.extract! event, :id, :start, :end, :is_closed, :is_rated
  json.url event_url(event, format: :json)
end

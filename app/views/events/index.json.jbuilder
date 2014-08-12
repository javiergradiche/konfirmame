json.array!(@events) do |event|
  json.extract! event, :id, :recurring_rule
  json.url event_url(event, format: :json)
end

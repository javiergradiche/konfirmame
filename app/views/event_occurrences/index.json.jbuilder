json.array!(@event_occurrences) do |event_occurrence|
  json.extract! event_occurrence, :id, :event_id, :when, :state, :aforo, :confirmations
  json.url event_occurrence_url(event_occurrence, format: :json)
end

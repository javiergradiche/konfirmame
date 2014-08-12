json.array!(@notifications) do |notification|
  json.extract! notification, :id, :event_id, :occurrence_id, :user_id, :status, :comment
  json.url notification_url(notification, format: :json)
end

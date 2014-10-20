json.array!(@events) do |event|
  json.extract! event, :id, :date, :title, :content, :image, :caption, :timeline_id
  json.url event_url(event, format: :json)
end

json.array!(@newsletters) do |newsletter|
  json.extract! newsletter, :id, :name, :user_id
  json.url newsletter_url(newsletter, format: :json)
end

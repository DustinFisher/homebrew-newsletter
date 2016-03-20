json.array!(@links) do |link|
  json.extract! link, :id, :name, :description, :url, :email_id, :user_id
  json.url link_url(link, format: :json)
end

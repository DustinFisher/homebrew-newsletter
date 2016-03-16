json.array!(@emails) do |email|
  json.extract! email, :id, :name, :newsletter_id, :send_date
  json.url email_url(email, format: :json)
end

json.array!(@banners) do |banner|
  json.extract! banner, :id, :name, :content
  json.url banner_url(banner, format: :json)
end

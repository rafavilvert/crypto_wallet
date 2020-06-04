json.extract! coin, :id, :description, :string, :acronym, :url_image, :created_at, :updated_at
json.url coin_url(coin, format: :json)

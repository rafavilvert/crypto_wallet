json.extract! product, :id, :item, :volume, :price, :created_at, :updated_at
json.url product_url(product, format: :json)

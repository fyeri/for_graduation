json.extract! item, :id, :name, :character, :category, :purchased_on, :image, :created_at, :updated_at
json.url item_url(item, format: :json)

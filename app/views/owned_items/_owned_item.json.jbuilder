json.extract! owned_item, :id, :quantity, :remark, :created_at, :updated_at
json.url owned_item_url(owned_item, format: :json)

json.extract! conversation, :id, :caterer_id, :customer_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)

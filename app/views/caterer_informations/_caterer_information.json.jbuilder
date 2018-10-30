json.extract! caterer_information, :id, :name, :number, :address, :image, :about, :user_id, :created_at, :updated_at
json.url caterer_information_url(caterer_information, format: :json)

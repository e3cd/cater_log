# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# event_list = %w(Wedding Party Conference/Function Formal Cocktail/Nibbles Festival/Outdoor)
# event_list.each do |category|
#     EventType.create(category: category)
# end

users = []
n = 10

#Fill User table with email and password from faker, and is_caterer as a random value from true and false
n.times do 
    user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "password",#Faker::Internet.password(8),
        is_caterer: [true, false].sample
    )
    users.push(user.id)
end

#Populate CatererInformation with Faker
users.each do |user_id|
    CatererInformation.create(
        business_name: Faker::Food.dish,
        user_id: user_id,
        number: Faker::Number.number(10),
        address: Faker::Address.street_address,
        remote_image_url: Faker::LoremFlickr.image,
        about: Faker::MichaelScott.quote,
        type_of_event: rand(6).to_i
    )

    CatererMenu.create(
        description: Faker::HowIMetYourMother.quote,
        price: Faker::Number.decimal(2),
        user_id: user_id
    )
end



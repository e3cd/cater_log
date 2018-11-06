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
caterer_menu = [1,2,3,4,5,6,7,8]
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

#Populate CatererInformation and CatererMenu and History with Faker
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
    # caterer_menu.push(caterer_menu.id)
end

# n.times do
#     user_sample = users.sample
#     menu_sample = caterer_menu.sample
#     random_num = rand(150).to_i
#     History.create(
#         booking_date: Faker::Date.forward(53),
#         user_id: user_sample,
#         caterer_menu_id: menu_sample,
#         first_name: User.find(user_sample).first_name,
#         email: User.find(user_sample).email,
#         caterer_name: CatererInformation.find_by(CatererMenu.find(menu_sample).user_id)[:business_name],
#         has_paid: true,
#         number_of_heads: random_num,
#         price: (random_num * CatererMenu.find(menu_sample).price)
#     )
# end
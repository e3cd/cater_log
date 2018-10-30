# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
event_list = %w(Wedding Party Conference/Function Formal Cocktail/Nibbles Festival/Outdoor)
event_list.each do |category|
    EventType.create(category: category)
end
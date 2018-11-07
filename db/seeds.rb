#arrays to store user_ids as they are created
customer_users = []
caterer_users = []
caterer_menus = []
conversation_array = []
histories = []
conversations = []

#n is however many records we want to make
n = 20

######### USERS #############
n.times do 
    user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "password",#Faker::Internet.password(8),
        is_caterer: [true, false].sample,
        ##### NOT NEEDED AS ITS AUTOMATICALLY DONE #######
        # customer_id: "cus_DvC" + Faker::Crypto.sha1[0..11]
    )
    user.is_caterer? ? caterer_users.push(user.id) : customer_users.push(user.id)
end

######### CATERER_INFO and CATERER_MENU #############
n.times do 
    random_caterer = caterer_users.sample
    info = CatererInformation.create(
        business_name: Faker::Company.name,
        user_id: random_caterer,
        number: Faker::Number.number(10),
        address: Faker::Address.street_address,
        remote_image_url: Faker::Company.logo,
        about: Faker::SiliconValley.quote,
        type_of_event: rand(6).to_i
    )

    menu = CatererMenu.create(
        description: Faker::Food.description,
        price: Faker::Number.decimal(2),
        user_id: random_caterer
    )
    caterer_menus.push(menu.id)
end

######### HISTORY #############
n.times do
    random_menu = caterer_menus.sample
    random_number = rand(20..200)
    random_user = customer_users.sample
    history = History.create(
        #When seeding booking-date, 'on_or_after' must be commented out in 'history.rb', so previous records can be created
        booking_date: [Faker::Date.backward(60), Faker::Date.forward(180)].sample,
        user_id: random_user,
        caterer_menu_id: random_menu,
        number_of_heads: random_number,
        price: random_number * CatererMenu.find(random_menu).price,
        stripe_charge_id: "ch_1DT" + Faker::Crypto.sha1[0..21],
        first_name: User.find(random_user).first_name,
        email: User.find(random_user).email,
        caterer_name: CatererMenu.find(random_menu).user.caterer_information.business_name,
        has_paid: true
    )
    histories.push(history)
end

######### REVIEW #############
histories.each do |history|
    #15 days ago, so there will be some records that require a review
    if history.booking_date < 15.days.ago
        review = Review.create(
            rating: rand(6).to_i,
            content: Faker::FamousLastWords.last_words,
            user_id: history.user_id,
            history_id: history.id
        )
    end
end

######### CONVERSATION and MESSAGE #############
n.times do
    #Create an array with a mix of caterer and customer ideas, that will then be made unique
    conversation_array.push([caterer_users.sample, customer_users.sample])
end

conversation_array.uniq!

conversation_array.each do |conversation|
    convo = Conversation.create(
        caterer_id: conversation[0],
        customer_id: conversation[1]
    )
    conversations.push(convo)
end

conversations.each do |conversation|
    #Up to 5 messages in each conversation
    m = rand(6)
    m.times do
        message = Message.create(
            content: Faker::GreekPhilosophers.quote,
            conversation_id: conversation.id,
            user_id: [conversation.customer_id, conversation.caterer_id].sample 
        )
    end
end

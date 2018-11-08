class UserMailer < ApplicationMailer
    # before_action :caterer_email, only: [:booking_successful]
    default from: 'admin@caterlog.com'
    
    def booking_successful
        @user = params[:user]
        @history = params[:history]
        @url = 'https://caterlog.herokuapp.com/'
        mail(to: @user.email, subject: "Booking Confirmed!")
    end

    # def caterer_email
    #     history = params[:history]
    #     menu = CatererMenu.find(history.caterer_menu_id)
    #     @caterer_email = User.find(menu.user_id).email
    # end
end

####### LATER -- HOOK UP AN EMAIL TO CATERER #######

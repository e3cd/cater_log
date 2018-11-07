class UserMailer < ApplicationMailer
    default from: 'admin@caterlog.com'
    
    def booking_successful
        @user = params[:user]
        mail(to: @user.email, subject: "Booking Confirmed!")
    end
end

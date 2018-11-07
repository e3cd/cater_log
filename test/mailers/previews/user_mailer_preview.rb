class UserMailerPreview < ActionMailer::Preview
    def booking_successful
      UserMailer.with(user: User.first).booking_successful
    end
end
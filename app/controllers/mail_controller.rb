class MailController < ApplicationController
    before_action :authenticate_user!
    def index
        UserMailer.with(user: current_user).booking_successful.deliver_now
    end
end
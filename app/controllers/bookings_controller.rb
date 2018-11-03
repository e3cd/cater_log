class BookingsController < ApplicationController
    before_action :authenticate_user!

    def new
        @booking = History.new
    end

    def create
        @params = params
        respond_to do |format|
            if @params[:number_of_heads] != ""
                @booking = {
                    :date => @params[:date],
                    :time => @params[:time],
                    :user_id => current_user.id,
                    :caterer_menu_id => 3,
                    :number => @params[:number_of_heads]
                }
                format.html { redirect_to(confirm_booking_path(@booking))}
            else
                format.html{render :new}
                format.json { render json: @params, status: :unprocessable_entity }
            end
        end
    end
    
    # def book(booking)
    #     @history = booking
    #     byebug()
    #     if booking == 2
    #         nil
    #     end
    
    # end
end
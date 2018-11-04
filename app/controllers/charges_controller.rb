class ChargesController < ApplicationController
    before_action :authenticate_user!

    def new
    end
    
    def process_payment
      # Amount in cents
      @amount = 200 #change to booking_price (number of heads * price per head)
    
    #   customer = Stripe::Customer.create(
    #     :email => params[:stripeEmail],
    #     :source  => params[:stripeToken]
    #   )

      customer = Stripe::Customer.retrieve(current_user.customer_id)
      customer.source = params[:stripeToken]
      customer.save
    
      charge = Stripe::Charge.create(
        :customer    => current_user.customer_id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'aud',
        
      )
      # byebug()

      if params[:action] == "process_payment"
        @history = History.new
        @history.booking_date = params[:date]
        @history.user_id = current_user.id
        @history.caterer_menu_id = params[:caterer_menu_id]
        @history.price = (params[:number].to_f * 10) #10 is just a placeholder at the moment
        @history.stripe_charge_id = charge.id
        if @history.save
          format.html { redirect_to(success_path) }
        end
      end
      #   @history.save
        #render show history 
    # end
    
    # redirect_to success_path #change to receipt page
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/'
    end

    private

    def booking_price

    end
    
end

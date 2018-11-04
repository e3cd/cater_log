class ChargesController < ApplicationController
    before_action :authenticate_user!

    def new
    end
    
    def process_payment
      # Amount in cents
      @amount = booking_price
    
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

    redirect_to caterer_informations_path
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to caterer_informations_path
    end

    private

    def booking_price
      
    end
    
end

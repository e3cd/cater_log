class ChargesController < ApplicationController
    before_action :authenticate_user!

    def new
    end
    
    def process_payment
      # Amount in cents
      @amount = 500
    
    #   customer = Stripe::Customer.create(
    #     :email => params[:stripeEmail],
    #     :source  => params[:stripeToken]
    #   )
    
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'aud',
        :source  => params[:stripeToken]
      )

    redirect_to caterer_informations_path
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

    
end

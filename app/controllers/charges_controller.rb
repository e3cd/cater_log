class ChargesController < ApplicationController
    before_action :authenticate_user!
    
    def process_payment
      # Amount in cents
      @amount = (History.last[:price] * 100).to_i
  
      #Save the transaction to the customer
      customer = Stripe::Customer.retrieve(current_user.customer_id)
      customer.source = params[:stripeToken]
      customer.save
    
      #The actual charge
      charge = Stripe::Charge.create(
        :customer    => current_user.customer_id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'aud'
      )
  
      #Bit of an etch way to save the stripe_charge_id to the last history entry
      @last = History.last 
      @last.stripe_charge_id = charge.id
      @last.has_paid = true
      @last.save
      flash[:notice] = "Thanks #{current_user.first_name}! Your booking is complete!"
      redirect_to histories_path
  
      #Stripes rescue clause
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to '/'
    end
end

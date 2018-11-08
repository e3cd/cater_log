class ChargesController < ApplicationController
    before_action :authenticate_user!
    before_action :current_history, only: [:process_payment]
    
    def process_payment
      # Amount in cents
      @amount = (@history.price * 100).to_i
  
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
  
      #Update stripe charge and has paid to show the user has successfully paid
      @history.stripe_charge_id = charge.id
      @history.has_paid = true
      if @history.save
        UserMailer.with(user: current_user, history: @history).booking_successful.deliver_later
        flash[:notice] = "Thanks #{current_user.first_name}! Your booking is complete!"
        redirect_to histories_path
      end
  
      #Stripes rescue clause
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to '/'
    end

    def current_history
      @history = History.find(params[:id])
    end
end

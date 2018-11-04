module Payment

    def new
    end
    
    def process_payment(current_user)
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
        byebug()
    redirect_to '/' #change to receipt page
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/'
    end

    private

    def booking_price

    end
    
end

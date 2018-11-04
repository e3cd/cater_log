class HistoriesController < ApplicationController
before_action :authenticate_user!
  def index
    @histories = History.all
  end

  def new
    @history = History.new
  end

  def create
    # byebug()
    # @history = History.new(history_params)
    # @history.booking_date = 
    # @history.user_id = current_user.id
    # @history.caterer_menu_id = 
    # @history.price = 
    # respond_to do |format|
    #   if @history.save
    #       format.html { redirect_to(new_caterer_menu_path)}
    #   else
    #       format.html{render :new}
    #       format.json { render json: @caterer_information.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def book
    @user = current_user
    @price = (params[:number].to_f * 10)

  end

  def success
        # @history = History.new
        # @history.booking_date = params[:date]
        # @history.user_id = current_user.id
        # @history.caterer_menu_id = params[:caterer_menu_id]
        # @history.price = (params[:number].to_f * 10) #10 is just a placeholder at the moment
        # @history.stripe_charge_id = 2 #charge.id
        # respond_to do |format|
        # if @history.save
        #   fo
  end



end

class HistoriesController < ApplicationController

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
    @history = History.new
    @history.booking_date = params[:date]
    @history.user_id = current_user.id
    @history.caterer_menu_id = params[:caterer_menu_id]
    @history.price = (params[:number].to_f * 10) #10 is just a placeholder at the moment
    @history.save
    #render show history 
  end
end

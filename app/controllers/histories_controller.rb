class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_history, only: [:show, :edit, :update, :destroy]

  #Show all histories for the unique user
  def index
    if current_user.is_caterer?
      #If current user is a caterer, only show history with their id
      @current_caterer_menus = CatererMenu.where(user_id: current_user.id)
      @histories = []
      @current_caterer_menus.each do |menu|
        @histories.push(History.where(caterer_menu_id: menu.id))
      end
    else
      #If current user is a customer, only show their history
      @histories = History.where(user_id: current_user.id)
    end
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    @history = History.new
    @caterer_menu_id = params[:id]
    @caterer_menu = CatererMenu.find(@caterer_menu_id)
    @caterer_name = CatererInformation.find_by(user_id: @caterer_menu.user_id)[:business_name]
    @menu = @caterer_menu[:description]
    @cost = @caterer_menu[:price]
  end

  #Add new booking to database, then redirect to stripe payment
  def create
    #Calculating the total_price of the booking
    @caterer_menu_id = params[:history][:caterer_menu_id]
    @caterer_menu = CatererMenu.find(@caterer_menu_id)
    @cost = @caterer_menu[:price]
    @total_price = @cost * (params[:history][:number_of_heads]).to_i #* 100 #times 100 as Stripe deals in cents

    #Saving History to the database
    @history = History.new(history_params)
    @history.price = @total_price
    @history.user_id = current_user.id
    @history.save

    respond_to do |format|
      if @history.save
        format.html { redirect_to confirm_booking_path, notice: 'Please confirm details.' }
      else
        ########### BUG!!! NEEDS ERROR MESSAGES!!!!!! ###############
        format.html { redirect_to new_booking_path id: 4 }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @last = History.last
    @caterer = CatererMenu.find(@last[:caterer_menu_id])
    @caterer_name = CatererInformation.find_by(user_id: @caterer.user_id)[:business_name]
    @total_price = @last[:price]
    @user = current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:first_name, :email, :booking_date, :number_of_heads, :caterer_menu_id, :number)
    end
end
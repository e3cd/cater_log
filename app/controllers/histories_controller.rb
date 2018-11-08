class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :set_caterer_menu_id, only: [:new, :create]
  before_action :is_caterer, only: [:new, :create, :confirm]

  #Show all histories for the unique user
  def index
    @is_caterer = current_user.is_caterer
    @no_history = History.no_history(current_user.id) if !@is_caterer
    @date = Date.today
    if current_user.is_caterer?
      #If current user is a caterer, only show history with their id
      @histories = []
      #Loop through all the caterer menus to find which ones are in history
      current_user.caterer_menus.each do |menu|
        @histories.push(History.where(caterer_menu_id: menu.id))
      end
      #Little hack, as it saves an array
      @histories = @histories[0]
    else
      #If current user is a customer, only show their history
      @histories = History.where(user_id: current_user.id)
    end
    unless @histories == nil
      @histories = @histories.sort_by &:booking_date
    end
    @review = Review.all
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
    @review = History.any_review(@history)
  end

  def new
    @history = History.new
  end

  #Add new booking to database, then redirect to stripe payment
  def create
    @total_price = @cost * (params[:history][:number_of_heads]).to_f #* 100 #times 100 as Stripe deals in cents
    @history = History.new(history_params)
    @history.price = @total_price
    @history.user_id = current_user.id
    @history.caterer_name = @caterer_name
    @history.save
    if @history.save
      redirect_to confirm_booking_path, notice: 'Please confirm details.'
    else
      render action: "new", assigns: {id: @caterer_menu_id}
    end
  end


  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  ######### STILL AN ISSUE WITH LAST HERE...HOPEFULLY BE ABLE TO SELECT THE PROPER ONE, SO THEN SOMEONE CAN COME BACK AND PAY ########
  def confirm
    # @unpaid = History
    @last = History.last
    @caterer = CatererMenu.find(@last[:caterer_menu_id])
    @caterer_name = CatererInformation.find_by(user_id: @caterer.user_id)[:business_name]
    @total_price = @last[:price]
    @user = current_user
  end


  private

  def set_history
    @history = History.find(params[:id])
  end


  def history_params
    params.require(:history).permit(:first_name, :email, :booking_date, :number_of_heads, :caterer_menu_id, :caterer_name)
  end

  def set_caterer_menu_id
    @caterer_menu_id ||= params[:id]
    @caterer_menu_id ||= params[:history][:caterer_menu_id]
    @caterer_menu = CatererMenu.find(@caterer_menu_id)
    @caterer_name = CatererInformation.find_by(user_id: @caterer_menu.user_id)[:business_name]
    @menu = @caterer_menu[:description]
    @cost = @caterer_menu[:price]
  end

  def is_caterer
    if current_user.is_caterer?
      redirect_to root_path, notice: "Caterers cannot make bookings"
    end
  end
end
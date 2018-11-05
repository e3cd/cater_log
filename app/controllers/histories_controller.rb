class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_history, only: [:show, :edit, :update, :destroy]

  # GET /histories
  # GET /histories.json
  def index
    @histories = History.all
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    @history = History.new
    caterer_menu = CatererMenu.find(params[:menu])
    @caterer_name = CatererInformation.find_by(user_id: params[:menu])[:business_name]
    @menu = caterer_menu[:description]
    @cost = caterer_menu[:price]
  end

  # POST /histories
  # POST /histories.json
  def create
    # byebug()
    number = params[:history][:number_of_heads]
    price = number # * there has to be a way to access caterer_menu_price
    @history = History.new(history_params)
    @history.price = price
    @history.user_id = current_user.id
    @history.caterer_menu_id = 4 #Arbitrary number for the moment
    respond_to do |format|
      if @history.save
        format.html { redirect_to confirm_booking_path, notice: 'Please confirm details.' }
        # format.json { render :show, status: :created, location: @history }
      else
        format.html { render :new }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
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
    @total_price = @caterer[:price] * @last[:number_of_heads]
    @user = current_user
  end

  def success
    #only a temp fix, as it may not always be the last
    @recent = History.last
    @recent.stripe_charge_id = params[:charge]
    @recent.has_paid = true
    @recent.save
    byebug()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:first_name, :email, :number, :booking_date, :number_of_heads)
    end
end
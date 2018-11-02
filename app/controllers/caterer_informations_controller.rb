class CatererInformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_caterer_information, only: [:edit, :update, :destroy]
  ############ Before action - ensure is_caterer #####################
  # before_action :is_caterer

  # GET /caterer_informations
  # GET /caterer_informations.json
  def index
    # @caterer_informations = CatererInformation.all
  end

  # GET /caterer_informations/1
  # GET /caterer_informations/1.json
  def show
    #Find by, so it is just the one result, not an array of one
    @caterer_information = CatererInformation.find_by(user_id: current_user.id)
    #Where, so its an array, and each can be used
    @caterer_menu = CatererMenu.where(user_id: current_user.id)
    #i as an index, so it will change the package number
    @i = 1
  end

  # GET /caterer_informations/new
  def new
    @caterer_information = CatererInformation.new
  end

  # GET /caterer_informations/1/edit
  def edit
  end

  # POST /caterer_informations
  # POST /caterer_informations.json
  def create
    @caterer_information = CatererInformation.new(caterer_information_params)
    @caterer_information.user_id = current_user.id
    if @caterer_information.save
      redirect_to  new_caterer_menu_path
    else
      render :new
      render json: @caterer_information.errors, status: :unprocessable_entity
    end


    # if @caterer_information.save
    #   render root_path
    # else
    #   format.html { render :new }
    #   format.json { render json: @caterer_information.errors, status: :unprocessable_entity }
    # end

    # respond_to do |format|
    #   if @caterer_information.save
    #     render :events

    #     # format.html { redirect_to @caterer_information, notice: 'Caterer information was successfully created.' }
    #     # format.json { render :show, status: :created, location: @caterer_information }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @caterer_information.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def events
    @event_type = EventType.all
  end

  # PATCH/PUT /caterer_informations/1
  # PATCH/PUT /caterer_informations/1.json
  def update
    # respond_to do |format|
    #   if @caterer_information.update(caterer_information_params)
    #     format.html { redirect_to @caterer_information, notice: 'Caterer information was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @caterer_information }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @caterer_information.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /caterer_informations/1
  # DELETE /caterer_informations/1.json
  def destroy
    # @caterer_information.destroy
    # respond_to do |format|
    #   format.html { redirect_to caterer_informations_url, notice: 'Caterer information was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caterer_information
      @caterer_information = CatererInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def caterer_information_params
      params.require(:caterer_information).permit(:name, :number, :address, :image, :about, :user_id, :type_of_event)
    end

    # def is_caterer
    #   current_user.is_caterer
    # end
end

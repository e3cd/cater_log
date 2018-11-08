class CatererInformationsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_caterer_information, only: [:edit, :update, :destroy, :show]
  before_action :has_profile, only: [:show]

  def show
    #Where, so its an array, and each can be used
    @caterer_menu = CatererMenu.current_records.where(user_id: @caterer_information.user_id)
    #i as an index, so it will change the package number
    @i = 1
  end

  def new
    @caterer_information = CatererInformation.new
  end

  def edit
  end

  def create
    @caterer_information = CatererInformation.new(caterer_information_params)
    @caterer_information.user_id = current_user.id
    respond_to do |format|
      if @caterer_information.save
          format.html { redirect_to(new_caterer_menu_path)}
      else
          format.html{render :new}
          format.json { render json: @caterer_information.errors, status: :unprocessable_entity }
      end
    end
  end

  def events
    @event_type = EventType.all
  end

  def update
    respond_to do |format|
      if @caterer_information.update(caterer_information_params)
        format.html { redirect_to @caterer_information, notice: 'Caterer information was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  ######## IF WE DELETE USER FROM DEVISE LATER ... THIS CAN JUST BE A LINK TO THAT METHOD ####
  # def destroy
  #   @caterer_information.destroy
  #   respond_to do |format|
  #     format.html { redirect_to caterer_informations_url, notice: 'Caterer information was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caterer_information
      @caterer_information = CatererInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def caterer_information_params
      params.require(:caterer_information).permit(:business_name, :number, :address, :image, :about, :user_id, :type_of_event)
    end

    #if user is a caterer, but hasn't made a profile, this will redirect them to the register page...use find_by to return nil, instead of breaking
    def has_profile
      if current_user && current_user.is_caterer? && CatererInformation.find_by(user_id: current_user.id) == nil
        redirect_to new_caterer_information_path, notice: "Must create a Profile first"
      end
    end
end

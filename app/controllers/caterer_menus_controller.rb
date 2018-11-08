class CatererMenusController < ApplicationController
  before_action :set_caterer_menu, only: [:edit, :update, :destroy]

  def new
    @caterer_menu = CatererMenu.new
  end

  def edit
  end

  def create
    @caterer_menu = CatererMenu.new(caterer_menu_params)
    @caterer_menu.user_id = current_user.id
    respond_to do |format|
      if @caterer_menu.save
        @caterer = CatererInformation.find_by(user_id: @caterer_menu.user_id)
        format.html { redirect_to caterer_information_path(@caterer)}
      else
          format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @caterer_menu.update(caterer_menu_params)
        @user_id = @caterer_menu.user_id
        @caterer_information = CatererInformation.find_by(user_id: @user_id)
        format.html { redirect_to caterer_information_path(@caterer_information), notice: 'Caterer menu was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  ###### CAN'T DELETE AS ITS RELATED TO HISTORY ######
  def destroy
    @caterer_menu.destroy
    respond_to do |format|
      format.html { redirect_to caterer_menus_url, notice: 'Caterer menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caterer_menu
      @caterer_menu = CatererMenu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def caterer_menu_params
      params.require(:caterer_menu).permit(:description, :price)
    end
end

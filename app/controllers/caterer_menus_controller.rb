class CatererMenusController < ApplicationController
  before_action :set_caterer_menu, only: [:show, :edit, :update, :destroy]

  # GET /caterer_menus
  # GET /caterer_menus.json
  def index
    @caterer_menus = CatererMenu.all
  end

  # GET /caterer_menus/1
  # GET /caterer_menus/1.json
  def show
  end

  # GET /caterer_menus/new
  def new
    @caterer_menu = CatererMenu.new
  end

  # GET /caterer_menus/1/edit
  def edit
  end

  # POST /caterer_menus
  # POST /caterer_menus.json
  def create
    @caterer_menu = CatererMenu.new(caterer_menu_params)
    @caterer_menu.user_id = current_user.id

    respond_to do |format|
      if @caterer_menu.save
        format.html { redirect_to @caterer_menu, notice: 'Caterer menu was successfully created.' }
        format.json { render :show, status: :created, location: @caterer_menu }
      else
        format.html { render :new }
        format.json { render json: @caterer_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caterer_menus/1
  # PATCH/PUT /caterer_menus/1.json
  def update
    respond_to do |format|
      if @caterer_menu.update(caterer_menu_params)
        format.html { redirect_to @caterer_menu, notice: 'Caterer menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @caterer_menu }
      else
        format.html { render :edit }
        format.json { render json: @caterer_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caterer_menus/1
  # DELETE /caterer_menus/1.json
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

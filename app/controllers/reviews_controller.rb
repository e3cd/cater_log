class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :destroy]
  before_action :set_history_id, only: [:new, :create]

  
  def show
    @caterer_name = History.find(@review.history_id).caterer_name
  end


  def new
    @review = Review.new
  end


  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.history_id = @history_id
    if @review.save
      redirect_to histories_path, notice: 'Review was successfully created.'
    else
      render action: "new", assigns: {history_id: @history_id}
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :content)
    end

    def set_history_id
      @history_id ||= params[:history_id]
      @history_id ||= params[:review][:history_id]
      @caterer_name = History.find(@history_id)[:caterer_name]
    end
end

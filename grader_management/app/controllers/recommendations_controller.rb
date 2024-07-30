class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.recommender_id = current_user.id

    if @recommendation.save
      redirect_to recommendations_path, notice: 'You have created a recommendation successfully!'
    else
      render :new
    end
  end

  def index
    @recommendations = Recommendation.all
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:recommended_id, :course_id, :message)
  end
end
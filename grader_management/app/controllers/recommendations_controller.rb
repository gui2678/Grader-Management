class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recommendation = Recommendation.new
    @courses = Course.all.pluck(:course_name, :id) # Fetch course names and IDs
    @username = params[:username] # Pre-fill username if available
  end

  def create
    Rails.logger.debug "Parameters: #{params.inspect}" # Log parameters for debugging

    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.recommender_id = current_user.id

    email = params[:recommendation][:email]
    username = params[:recommendation][:username]

    if username.present? && email.blank?
      email = "#{username}@osu.edu"
    end

    recommended_user = User.find_by(email: email)

    if recommended_user
      Rails.logger.debug "Recommended User: #{recommended_user.inspect}"
      @recommendation.recommended_id = recommended_user.id
    else
      # If no user is found, save the first and last name from the form as placeholders
      @recommendation.recommended_id = nil
      Rails.logger.info "Recommendation saved with placeholder for new user. Admin follow-up required."
      flash.now[:notice] = 'Recommendation created successfully with a placeholder for the recommended user. Admin will follow up to complete the user creation.'
    end

    if @recommendation.save
      redirect_to recommendations_path, notice: 'Recommendation created successfully!'
    else
      @courses = Course.all.pluck(:course_name, :id)
      render :new
    end
  end

  def index
    @recommendations = Recommendation.includes(:recommender, :recommended, :course).all
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:display_name, :first_name, :last_name, :email, :course_id, :section_number, :message, :username)
  end
end

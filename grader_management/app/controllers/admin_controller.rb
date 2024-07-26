class AdminController < ApplicationController
  before_action :check_admin
  skip_before_action :verify_authenticity_token, only: [:fetch_class_info, :approve_requests]

  def index
    @users = User.all
    @courses = Course.all
  end
  
  def approve_requests
    Rails.logger.debug "Params: #{params.inspect}" 
    user = User.find_by(id: params[:user_id])
    Rails.logger.debug "User: #{user.inspect}" 
    if user.nil?
      redirect_to admin_index_path, alert: 'User not found.'
    elsif user.update_column(:approved, params[:approved] == '1')
      Rails.logger.debug "User approval status updated successfully for user: #{user.id}" 
      redirect_to admin_index_path, notice: 'User approval status updated successfully.'
    else
      Rails.logger.debug "Failed to update user approval status for user: #{user.id}"
      redirect_to admin_index_path, alert: 'Failed to update user approval status.'
    end
  end

  def test
    @courses = Course.all
  end

  def fetch_class_info
    fetcher = FetchClassInfo.new(term: params[:term], campus: params[:campus])
    fetcher.call
    redirect_to admin_database_test_path, notice: 'Class information fetched successfully.'
  end
end

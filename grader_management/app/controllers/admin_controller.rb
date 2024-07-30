class AdminController < ApplicationController
  require 'devise'
  before_action :authenticate_user!
  before_action :check_admin
  skip_before_action :verify_authenticity_token, only: [:fetch_class_info, :approve_requests]

  def index
    @users = User.where.not(role: 'student')
    @courses = Course.all
  end

  def approve_requests
    Rails.logger.debug "Params: #{params.inspect}"
    user = User.find_by(id: params[:user_id])
    Rails.logger.debug "User: #{user.inspect}"
    if user
      if user.update(approved: params[:approved] == '1')
        Rails.logger.debug "User approval status updated successfully for user: #{user.id}"
        redirect_to admin_index_path, notice: 'User approval status updated successfully.'
      else
        Rails.logger.error "Failed to update user approval status for user: #{user.id}. Errors: #{user.errors.full_messages.join(', ')}"
        redirect_to admin_index_path, alert: 'Failed to update user approval status.'
      end
    else
      Rails.logger.error "User not found with ID: #{params[:user_id]}"
      redirect_to admin_index_path, alert: 'User not found.'
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

  private

  def check_admin
    if current_user.admin?
      unless current_user.approved?
        unless session[:unapproved_admin_alert_shown]
          flash[:alert] = 'Unapproved admin - your account will be restricted to student features until approval'
          session[:unapproved_admin_alert_shown] = true
        end
        redirect_to root_path
      end
    else
      redirect_to root_path, alert: 'Not authorized'
    end
  end
end

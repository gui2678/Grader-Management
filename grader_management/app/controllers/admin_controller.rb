class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  skip_before_action :verify_authenticity_token, only: [:fetch_class_info]

  def index
    @users = User.all
    @courses = Course.all
  end

  def approve_requests
    user = User.find(params[:user_id])
    if user.update_column(:approved, params[:approved])
      redirect_to admin_index_path, notice: 'User approval status updated successfully.'
    else
      redirect_to admin_index_path, alert: 'Failed to update user approval status.'
    end

  end

  def approve_user_path

  end

  private

  def check_admin
    redirect_to(root_path, alert: 'Not authorized') unless current_user.admin?
  end
end

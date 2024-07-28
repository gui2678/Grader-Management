class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  private
  def route_not_found
    redirect_to root_path, alert: "Page not found."
  end
  
  def check_admin
    unless current_user&.admin? && current_user.approved?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end

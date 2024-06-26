class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def check_permission(permission)
    unless current_user.has_permission?(permission)
      flash[:alert] = "You do not have permission to perform this action."
      redirect_to root_path
    end
  end
end

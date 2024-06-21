# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    super do |resource|
      if resource.persisted?
        set_flash_message! :notice, :signed_up #Set the flash message
      end
    end
  end
  # private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :role)
  end

  # PUT /resource
  def update
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

end

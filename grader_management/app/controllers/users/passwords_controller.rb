# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
    before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]

  def update
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to root_path, notice: 'Password updated successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end

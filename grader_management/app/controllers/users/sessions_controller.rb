# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  #Session Create when user login
  def create
     user = User.find_by(email: params[:user][:email])
    if user
      puts "User found: #{user.email}"

      # Authenticate the user with the provided password
      if user.valid_password?(params[:user][:password])
        puts "Password is valid"
        puts user.approved
        if user.approved?
          puts "User is approved"
          sign_in(user)
          redirect_to '/home/index'
        else
          puts "User is not approved"
          redirect_to new_user_session_path, alert: 'Your account is not approved yet.'
        end
      else
        puts "Password is invalid"
        redirect_to new_user_session_path, alert: 'Invalid email or password.'
      end
    else
      puts "User not found"
      redirect_to new_user_session_path, alert: 'Invalid email or password.'
    end
  end
end

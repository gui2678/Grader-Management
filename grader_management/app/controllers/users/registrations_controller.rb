# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      end
      redirect_to after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      refresh_database
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
                    :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private

  def refresh_database
    # Logic to refresh the database, e.g., reloading data from external sources
    new_data = fetch_data_from_external_source
    update_database_with_new_data(new_data)
  end

  def fetch_data_from_external_source
    [
      { course_number: 'CSE 2221', section: '001', grader_needed: true },
      { course_number: 'CSE 2231', section: '002', grader_needed: false }
    ]
  end

  def update_database_with_new_data(new_data)
    new_data.each do |data|
      course = Course.find_by(course_number: data[:course])
      if course
        section = Section.find_or_initialize_by(course: course, section_number: data[:section])
        section.update(grader_needed: data[:grader_needed])
      else
        Rails.logger.error "Sorry! Course is not found: #{data[:course]}"
      end
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :role)
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end
end

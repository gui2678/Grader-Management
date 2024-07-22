class CustomFailureApp < Devise::FailureApp
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end

  def i18n_message(default = nil)
    scope = "devise.failure"
    message = warden_message || default || :unauthenticated

    if message.is_a?(Symbol)
      I18n.t("#{scope}.#{message}", resource_name: scope_name, scope: "devise.failure", default: [message])
    else
      message.to_s
    end
  end

  private

  def scope_name
    warden_options[:scope]
  end

  def redirect
    store_location!
    flash[:alert] = i18n_message
    redirect_to new_user_session_path # Redirect to the login page
  end
end

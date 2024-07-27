Devise.setup do |config|
  require 'devise/orm/active_record'

  # Configure the custom failure app
  config.warden do |manager|
    manager.failure_app = CustomFailureApp
  end

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  # Enforce email format to be name.#@osu.edu with a period before the number
  config.email_regexp = /\A[a-zA-Z0-9._%+-]+\.\d+@osu\.edu\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
end

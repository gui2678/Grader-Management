require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

Bundler.require(*Rails.groups)

module GraderManagement
  class Application < Rails::Application
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files in config/environments, which are processed later.
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Remove or correct any erroneous configurations
    # config.autoload_lib = "#{config.root}/lib" # This line is incorrect and should be removed or corrected
  end
end

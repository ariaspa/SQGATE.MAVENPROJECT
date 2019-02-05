require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FrontendPolApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    

    #rimuove controllo token 
    config.action_controller.allow_forgery_protection = false

    config.frontend = Rails.application.config_for(:frontend)

  end
end

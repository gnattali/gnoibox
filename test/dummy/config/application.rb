require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "gnoibox"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.before_initialize do
      Gnoibox::S3.configure do |config|
        config.access_key_id = ENV['S3_ACCESS_KEY_ID']
        config.secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
        config.region = ENV['S3_REGION']
        config.bucket = ENV['S3_BUCKET']
      end
    end

  end
end

require File.expand_path('../boot', __FILE__)

require "rails/all"

Bundler.require(*Rails.groups)
require "mountain_view"

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

    # support newer rails without warnings
    config.active_support.test_order = :random rescue nil

    # Settings specified here will take precedence over those in config/application.rb.

    # The test environment is used exclusively to run your application's
    # test suite. You never need to work with it otherwise. Remember that
    # your test database is "scratch space" for the test suite and is wiped
    # and recreated between test runs. Don't rely on the data there!
    config.cache_classes = true

    # Do not eager load code on boot. This avoids loading your whole application
    # just for the purpose of running a single test. If you are using a tool that
    # preloads Rails for running tests, you may have to set it to true.
    config.eager_load = true

    # Configure static asset server for tests with Cache-Control for performance.
    config.static_cache_control = 'public, max-age=3600'

    config.assets.enabled = true

    # Show full error reports and disable caching.
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false

    # Raise exceptions instead of rendering exception templates.
    config.action_dispatch.show_exceptions = false

    # Disable request forgery protection in test environment.
    config.action_controller.allow_forgery_protection = false

    # Print deprecation notices to the stderr.
    config.active_support.deprecation = :stderr

    # Raises error for missing translations
    # config.action_view.raise_on_missing_translations = true
  end
end


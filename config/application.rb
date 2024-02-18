require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wanoryokouki
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
  
  config.after_initialize do
    guest_user = User.find_or_create_by(email: 'guest@example.com')
      
    guest_user.post_image.each { |post_image| post_image.destroy } if guest_user.post_images.any?
    guest_user.post_comments.each { |comment| comment.destroy } if guest_user.post_comments.any?
  end
end

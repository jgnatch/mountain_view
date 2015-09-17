require "mountain_view/version"
require "mountain_view/configuration"
require "mountain_view/presenter"

module MountainView
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

require "mountain_view/engine" if defined?(Rails)

MountainView.configure do |config|
  config.included_stylesheets = ["global"]
end

# include component classes
Dir.glob('app/components/**/*.rb') { |f| require_relative "../../#{f}" }

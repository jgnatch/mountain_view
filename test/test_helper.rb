# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("dummy/config/environment.rb", __dir__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
end
# for generators
require "rails/generators/test_case"
require "generators/mountain_view/component_generator"
require "generators/mountain_view/extra_pages_generator"
def header_stub_meta
  {
    meta: "There is this different classes",
    stubs: [
      {
        mv_stub_meta: {
          title: "Specific Example",
          description: "Instructions for use case and UX considerations",
          classes: "black-background",
          partial: "header/test_partial.html.erb"
        },
        id: 1,
        title: "20 Mountains you didn't know they even existed",
        subtitle: "Buzzfeed title"
      },
      {
        id: 2,
        title: "You won't believe what happened to this man at Aspen"
      }
    ]
  }
end

def header_stub_only
  header_stub_meta[:stubs]
end

def header_stub_first
  header_stub_only.first
end

require "rails"
require "mountain_view/component"

module MountainView
  class Engine < ::Rails::Engine
    isolate_namespace MountainView

    initializer "mountain_view.components_path" do |app|
      MountainView.configure do |c|
        c.components_path ||= app.root.join("app", "components")
      end
    end

    initializer "mountain_view.load_component_classes",
                before: :set_autoload_paths do |app|
      component_paths = "#{MountainView.configuration.components_path}/{*}"
      app.config.autoload_paths += Dir[component_paths]
    end

    initializer "mountain_view.assets" do |app|
      Rails.application.config.assets.paths <<
        MountainView.configuration.components_path
      Rails.application.config.assets.precompile += %w( mountain_view/styleguide.css
                                                        mountain_view/styleguide.js )
    end

    initializer "mountain_view.append_view_paths" do |app|
      ActiveSupport.on_load :action_controller do
        append_view_path MountainView.configuration.components_path
      end
    end

    initializer "mountain_view.add_helpers" do
      ActiveSupport.on_load :action_controller do
        helper MountainView::ApplicationHelper
        helper MountainView::ComponentHelper
      end
    end
  end
end

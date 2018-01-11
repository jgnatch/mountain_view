module MountainView
  module ComponentHelper
    def render_component(path, properties = {}, &block)
      component = MountainView::Presenter.component_for(path, properties)
      component.render(controller.view_context) do
        capture(&block) if block_given?
      end
    end
  end
end

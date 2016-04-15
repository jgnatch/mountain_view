module MountainView
  module ComponentHelper
    def render_component(slug, properties = {})
      component = MountainView::Presenter.component_for(slug, properties)
      component.render(controller.view_context)
    end
  end
end

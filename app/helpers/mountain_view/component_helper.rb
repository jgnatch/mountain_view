module MountainView
  module ComponentHelper
    def render_component(slug, properties = {})
      component = MountainView::Presenter.component_for(slug, properties)
      render partial: component.partial, locals: component.locals
    end
  end
end

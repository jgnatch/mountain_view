module MountainView
  module ComponentHelper
    def render_component(slug, properties = {})
      component = new_component(slug, properties)
      render partial: component.partial, locals: component.locals
    end

    def new_component(slug, properties={})
      klass = "#{slug.to_s.classify}Component".safe_constantize
      klass ||= MountainView::Presenter
      klass.new(slug, properties)
    end
  end
end

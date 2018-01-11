module MountainView
  class Presenter
    class_attribute :_properties, instance_accessor: false
    self._properties = {}

    attr_reader :path, :properties

    def initialize(path, properties = {})
      @path = path
      @properties = default_properties.deep_merge(properties)
    end

    def render(context, &block)
      context.extend ViewContext
      context.inject_component_context self
      properties[:yield] ||= yield
      context.render partial, partial: partial
    end

    def partial
      slug, path = @path.split(/\/(?=[^\/]*$)/).reverse
      path ? "#{path}/#{slug}/#{slug}" : "#{slug}/#{slug}"
    end

    private

    def default_properties
      self.class._properties.inject({}) do |sum, (k, v)|
        sum[k] = v[:default]
        sum
      end
    end

    class << self
      def component_for(*args)
        klass = "#{args.first.to_s.camelize}Component".safe_constantize
        klass ||= self
        klass.new(*args)
      end

      def properties(*args)
        opts = args.extract_options!
        properties = args.inject({}) do |sum, name|
          sum[name] = opts
          sum
        end
        define_property_methods(args)
        self._properties = _properties.merge(properties)
      end
      alias_method :property, :properties

      private

      def define_property_methods(names = [])
        names.each do |name|
          next if method_defined?(name)
          define_method name do
            properties[name.to_sym]
          end
        end
      end
    end

    module ViewContext
      attr_reader :_component
      delegate :properties, to: :_component

      def inject_component_context(component)
        @_component = component
        protected_methods = MountainView::Presenter.public_methods(false)
        methods = component.public_methods(false) - protected_methods
        methods.each do |meth|
          next if self.class.method_defined?(meth)
          self.class.delegate meth, to: :_component
        end
      end
    end
  end
end

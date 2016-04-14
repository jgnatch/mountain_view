module MountainView
  class Presenter
    class_attribute :_properties, instance_accessor: false
    self._properties = {}

    attr_reader :slug, :properties

    def initialize(slug, properties = {})
      @slug = slug
      @properties = property_defaults.deep_merge(properties)
    end

    def render(context)
      context = context.clone
      context.extend ViewContext
      context.inject_component_context(self)
      context.render partial: partial
    end

    def partial
      "#{slug}/#{slug}"
    end

    private

    def property_defaults
      self.class._properties.inject({}) do |sum, (k, v)|
        sum[k] = v[:default]
        sum
      end
    end

    class << self
      def properties(*args)
        opts = args.extract_options!
        properties = args.inject({}) do |sum, name|
          sum[name] = opts
          sum
        end
        define_property_methods(*args)
        self._properties = _properties.merge(properties)
      end
      alias_method :property, :properties

      def define_property_methods(*names)
        names.each do |name|
          next if method_defined?(name) 
          define_method name do
            properties[name.to_sym]
          end
        end
      end

      def component_for(*args)
        klass = "#{args.first.to_s.camelize}Component".safe_constantize
        klass ||= self
        klass.new(*args)
      end
    end

    module ViewContext
      attr_reader :_component
      delegate :properties, to: :_component

      def inject_component_context(component)
        @_component = component
        properties.keys.each do |prop|
          self.class.delegate prop, to: :_component
        end
      end
    end
  end
end

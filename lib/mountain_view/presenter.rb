module MountainView
  class Presenter < SimpleDelegator
    class_attribute :_properties, instance_accessor: false
    self._properties = {}

    attr_reader :slug, :properties
    alias_method :props, :properties

    def initialize(slug, properties = {})
      @slug = slug
      @properties = property_defaults.deep_merge(properties)
      super(OpenStruct.new(@properties)) # Could use method_missing?
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
        self._properties = _properties.merge(properties)
      end

      alias_method :property, :properties
    end

    def self.component_for(*args)
      klass = "#{args.first.to_s.camelize}Component".safe_constantize
      klass ||= self
      klass.new(*args)
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

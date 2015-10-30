module MountainView
  class Presenter
    class_attribute :_properties, instance_accessor: false
    self._properties = {}

    attr_reader :slug, :properties
    alias_method :props, :properties

    def initialize(slug, properties = {})
      @slug = slug
      @properties = property_defaults.deep_merge(properties)
    end

    def property_names
      @property_names ||= (properties.keys + self.class._properties.keys)
    end

    def partial
      "#{slug}/#{slug}"
    end

    def locals
      locals = build_locals
      locals.merge(properties: locals)
    end

    private

    def build_locals
      property_names.inject({}) do|sum, attr|
        sum[attr] = property_value(attr)
        sum
      end
    end

    def property_value(key)
      return unless property_names.include?(key)
      respond_to?(key) ? send(key) : properties[key]
    end

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

    def self.component_for(slug, properties = {})
      klass = "#{slug.to_s.camelize}Component".safe_constantize
      klass ||= self
      klass.new(slug, properties)
    end
  end
end

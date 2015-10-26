module MountainView
  class Presenter
    class_attribute :_attributes, instance_accessor: false
    self._attributes = {}

    attr_reader :slug, :properties
    alias_method :props, :properties

    def initialize(slug, properties = {})
      @slug = slug
      @properties = attribute_defaults.deep_merge(properties)
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
      attributes.inject({}) do|sum, attr|
        sum[attr] = attribute_value(attr)
        sum
      end
    end

    def attributes
      @attributes ||= (properties.keys + self.class._attributes.keys)
    end

    def attribute_value(key)
      return unless attributes.include?(key)
      respond_to?(key) ? send(key) : properties[key]
    end

    def attribute_defaults
      self.class._attributes.inject({}) do |sum, (k, v)|
        sum[k] = v[:default]
        sum
      end
    end

    class << self
      def attributes(*args)
        opts = args.extract_options!
        attributes = args.inject({}) do |sum, name|
          sum[name] = opts
          sum
        end
        self._attributes = _attributes.merge(attributes)
      end

      alias_method :attribute, :attributes
    end

    def self.component_for(slug, properties = {})
      klass = "#{slug.to_s.camelize}Component".safe_constantize
      klass ||= self
      klass.new(slug, properties)
    end
  end
end

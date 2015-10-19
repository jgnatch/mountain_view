module MountainView
  class Presenter
    class_attribute :_attributes, instance_accessor: false
    self._attributes = {}

    attr_reader :slug, :properties
    alias_method :props, :properties

    def initialize(slug, properties={})
      @slug = slug
      @properties = properties
    end

    def partial
      "#{slug}/#{slug}"
    end

    def locals
      locals = build_hash
      locals.merge(properties: locals)
    end

    def attributes
      @attributes ||= properties.keys.inject({}) do |sum, name|
        sum[name] = {}
        sum
      end.merge(self.class._attributes)
    end

    private

    def build_hash
      attributes.inject({}) do|sum, (k, v)|
        sum[k] = attribute_value(k)
        sum
      end
    end

    def attribute_value(key)
      attribute = attributes[key] || return
      value = respond_to?(key) ? send(key) : properties[key]
      value || attribute[:default]
    end

    class << self
      def attributes(*args)
        opts = args.extract_options!
        attributes = args.inject({}) do |sum, name|
          sum[name] = opts
          sum
        end
        self._attributes = self._attributes.merge(attributes)
      end

      alias_method :attribute, :attributes
    end

    def self.component_for(slug, properties={})
      klass = "#{slug.to_s.classify}Component".safe_constantize
      klass ||= self
      klass.new(slug, properties)
    end
  end
end

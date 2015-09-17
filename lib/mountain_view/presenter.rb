module MountainView
  class Presenter
    class_attribute :_attributes
    self._attributes = []

    attr_reader :slug, :properties

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
      _attributes + properties.keys
    end

    private

    def build_hash
      attributes.inject({}) do|sum, k|
        sum[k] = get_property(k)
        sum
      end
    end

    def get_property(key)
      if respond_to?(key)
        send(key)
      else
        properties[key]
      end
    end

    def self.attributes(*args)
      self._attributes += args
    end
  end
end

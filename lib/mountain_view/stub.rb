module MountainView
  class Stub
    def initialize(component_properties)
      @meta = component_properties[:mv_stub_meta] || {}
      @data = component_properties.except(:mv_stub_meta) || {}
    end

    def meta_title(example_title, example_number)
      if @meta.key?(:title)
        @meta[:title]
      else
        example_title + ' ' + (example_number + 1).to_s
      end
    end

    def meta_description
      @meta[:description] if @meta.key?(:description)
    end

    def meta_classes
      @meta[:classes] if @meta.key?(:classes)
    end

    def properties
      @data
    end
  end
end

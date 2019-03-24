# frozen_string_literal: true

module MountainView
  # Manage the information for a specific example stub in the style guide
  class Stub
    attr_reader :properties, :meta

    def initialize(component_properties)
      @meta = component_properties[:mv_stub_meta] || {}
      @properties = component_properties.except(:mv_stub_meta) || {}
    end

    def meta_title(example_title, example_number)
      if @meta.key?(:title)
        @meta[:title]
      else
        example_title + " " + (example_number + 1).to_s
      end
    end

    def meta_description
      @meta[:description]
    end

    def meta_classes
      @meta[:classes]
    end

    def meta_partial
      @meta[:partial]
    end
  end
end

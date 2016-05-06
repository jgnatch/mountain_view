module MountainView
  class Component
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def title
      @name.humanize
    end

    def styleguide_stubs
      handle_proc = proc { |type, val|
        _tag, _domain, object_type = type.split(":")
        case object_type
        when "Object"
          attrs = val["attributes"]
          obj = val["class"].constantize.new(attrs)
          MountainView::Helpers::ObjectWrapper.new(obj, attrs)
        when "Form"
          MountainView::Helpers::FormBuilder.new(val["for"])
        end
      }
      Psych.add_domain_type("mountain_view", "Object", &handle_proc)
      Psych.add_domain_type("mountain_view", "Form", &handle_proc)
      YAML.load_file(stubs_file) || {}
    rescue Errno::ENOENT
      {}
    end

    def component_stubs
      if styleguide_stubs.is_a?(Hash)
        styleguide_stubs[:stubs] || {}
      elsif styleguide_stubs.is_a?(Array)
        styleguide_stubs
      end
    end

    def component_stubs?
      component_stubs.any?
    end

    def stubs_file
      MountainView.configuration.components_path.join(name, "#{name}.yml")
    end

    def stubs?
      styleguide_stubs.any?
    end

    def stubs_extra_info?
      !stubs_extra_info.empty?
    end

    def stubs_extra_info
      if styleguide_stubs.is_a?(Hash) && styleguide_stubs.key?(:meta)
        styleguide_stubs[:meta]
      else
        {}
      end
    end

    def stubs_correct_format?
      stubs_are_a_hash_with_info? || styleguide_stubs.is_a?(Array)
    end

    def stubs_are_a_hash_with_info?
      styleguide_stubs.is_a?(Hash) && styleguide_stubs.key?(:stubs)
    end
  end
end

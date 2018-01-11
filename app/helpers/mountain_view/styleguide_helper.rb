module MountainView
  module StyleguideHelper
    def method_missing(method, *args, &block)
      if method.to_s.end_with?("_path") || method.to_s.end_with?("_url")
        if main_app.respond_to?(method)
          main_app.send(method, *args)
        else
          super
        end
      else
        super
      end
    end

    def respond_to?(method, include_all = false)
      if method.to_s.end_with?("_path") || method.to_s.end_with?("_url")
        if main_app.respond_to?(method, include_all)
          true
        else
          super
        end
      else
        super
      end
    end

    def prettify_word(word)
      word.to_s.split("_").map(&:capitalize).join(" ")
    end

    def mv_components
      component_dirs = MountainView.configuration.components_path.join("**/*/")
      Dir.glob(component_dirs).sort.map do |component_dir|
        MountainView::Component.new File.basename(component_dir)
      end
    end

    def extra_pages
      MountainView.configuration.extra_pages
    end
  end
end

module MountainView
  class Configuration
    attr_accessor :included_stylesheets
    attr_accessor :styleguide_path
    attr_accessor :extra_pages
    attr_accessor :skip_assets
    attr_reader :components_path

    def initialize
      @included_stylesheets = []
      @extra_pages = []
    end

    def components_path=(path)
      @components_path = Pathname.new(path)
    end
  end
end

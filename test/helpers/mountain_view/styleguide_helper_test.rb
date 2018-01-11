require 'test_helper'

class MountainView::StyleguideHelperTest < ActionView::TestCase
  test "returns components sorted alphabetically" do
    components = mv_components

    breadcrumbs = components.find { |c| c.name == "breadcrumbs" }
    header = components.find { |c| c.name == "header" }
    yielder = components.find { |c| c.name == "yielder" }

    assert components.index(breadcrumbs) < components.index(header)
    assert components.index(header) < components.index(yielder)
  end

  test "returns a nested component" do
    components = mv_components

    input = components.find { |c| c.name == "input" }

    assert components.index(input)
  end
end

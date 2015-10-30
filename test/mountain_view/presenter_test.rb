require "test_helper"
class InheritedPresenter < MountainView::Presenter
  properties :title, :description
  property :data, default: []

  def title
    "Foo#{properties[:title].downcase}"
  end
end

class MountainViewPresenterTest < ActiveSupport::TestCase
  def test_partial
    presenter = MountainView::Presenter.new("header")
    assert_equal "header/header", presenter.partial
  end

  def add_properties(properties)
    properties.merge(properties: properties)
  end
end

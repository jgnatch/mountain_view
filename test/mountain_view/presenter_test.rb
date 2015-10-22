require "test_helper"
class InheritedPresenter < MountainView::Presenter
  attributes :title, :description
  attribute :data, default: []

  def title
    "Foo#{properties[:title].downcase}"
  end
end

class MountainViewPresenterTest < ActiveSupport::TestCase
  def test_partial
    presenter = MountainView::Presenter.new("header")
    assert_equal "header/header", presenter.partial
  end

  def test_locals
    properties = {name: 'Foo', title: 'Bar'}
    presenter = MountainView::Presenter.new('header', properties)
    assert_equal add_properties(properties), presenter.locals
  end

  def test_inherited_locals
    properties = {name: 'Foo', title: 'Bar'}
    presenter = InheritedPresenter.new('header', properties)
    presenter_properties = {title: 'Foobar', description: nil, data: []}
    expected_properties = properties.merge(presenter_properties)
    assert_equal add_properties(expected_properties), presenter.locals
  end

  def add_properties(properties)
    properties.merge(properties: properties)
  end
end

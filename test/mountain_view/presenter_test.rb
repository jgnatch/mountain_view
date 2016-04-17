require "test_helper"

class InheritedPresenter < MountainView::Presenter
  properties :title, :description
  property :data, default: []

  def title
    "Foo#{properties[:title].downcase}"
  end
end

class MountainView::PresenterTest < ActiveSupport::TestCase
  test "returns the correct partial path" do
    presenter = MountainView::Presenter.new("header")
    assert_equal "header/header", presenter.to_partial_path
  end

  test "exposes properties as provided" do
    properties = {foo: "bar", hello: "world"}
    presenter = MountainView::Presenter.new("header", properties)
    assert_equal properties, presenter.properties
  end

  test "inherited presenter returns the correct title" do
    presenter = InheritedPresenter.new("inherited", title: "Bar")
    assert_equal "Foobar", presenter.title
  end

  test "inherited presenter responds to #data" do
    presenter = InheritedPresenter.new("inherited", data: ["Foobar"])
    assert_equal ["Foobar"], presenter.data
  end

  test "inherited presenter returns the default value for #data" do
    presenter = InheritedPresenter.new("inherited", {})
    assert_equal [], presenter.data
  end
end

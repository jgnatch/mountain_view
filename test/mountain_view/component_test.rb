require "test_helper"

class MountainViewComponentTest < ActiveSupport::TestCase
  def test_name
    component = MountainView::Component.new("header")

    assert_equal "header", component.name
  end

  def test_humanized_title
    component = MountainView::Component.new("social_media_icons")

    assert_equal "Social media icons", component.title
  end

  def test_styleguide_stubs
    component = MountainView::Component.new("header")
    expected_stub =
      {
        meta: "There is this different classes",
        stubs:
          [
            {
              id:  1,
              title: "20 Mountains you didn't know they even existed",
              subtitle: "Buzzfeed title"
            },
            { id: 2,
              title: "You won't believe what happened to this man at Aspen"
            }
          ]
      }

    assert_instance_of Hash, component.styleguide_stubs
    assert_equal expected_stub, component.styleguide_stubs
  end

  def test_component_stubs
    component = MountainView::Component.new("header")
    expected_stub =
      [
        {
          id: 1,
          title: "20 Mountains you didn't know they even existed",
          subtitle: "Buzzfeed title"
        },
        {
          id: 2,
          title: "You won't believe what happened to this man at Aspen"
        }
      ]
    assert_instance_of Array, component.component_stubs
    assert_equal expected_stub, component.component_stubs
  end

  def test_component_stubs?
    component_with_stubs = MountainView::Component.new("header")
    component_with_empty_stub_file = MountainView::Component.new("breadcrumbs")
    component_without_stub_file =
      MountainView::Component.new("social_media_icons")
    compoenet_with_stubs_but_incorrect_format =
      MountainView::Component.new("card")
    assert_equal true, component_with_stubs.component_stubs?
    assert_equal false, component_without_stub_file.component_stubs?
    assert_equal false, component_with_empty_stub_file.component_stubs?
    assert_equal true, compoenet_with_stubs_but_incorrect_format.
      component_stubs?
  end

  def test_stubs_extra_info
    component_with_extra_info = MountainView::Component.new("header")
    component_with_empty_stub_file =
      MountainView::Component.new("breadcrumbs")
    component_without_stub_file =
      MountainView::Component.new("paragraph")
    expected_extra_info_stub = "There is this different classes"

    assert_equal expected_extra_info_stub, component_with_extra_info.
      stubs_extra_info
    assert_equal true, component_with_empty_stub_file.stubs_extra_info.empty?
    assert_equal true, component_without_stub_file.stubs_extra_info.empty?
  end

  def test_stubs_extra_info?
    component_with_stubs = MountainView::Component.new("header")
    component_with_empty_stub_file =
      MountainView::Component.new("breadcrumbs")
    component_without_stub_file =
      MountainView::Component.new("social_media_icons")
    component_with_stubs_but_no_extra_info =
      MountainView::Component.new("card")

    assert_equal true, component_with_stubs.stubs_extra_info?
    assert_equal false, component_without_stub_file.stubs_extra_info?
    assert_equal false, component_with_empty_stub_file.stubs_extra_info?
    assert_equal false, component_with_stubs_but_no_extra_info.
      stubs_extra_info?
  end

  def test_stubs_correct_format?
    component_with_correct_stubs = MountainView::Component.new("header")
    component_with_empty_stub_file = MountainView::Component.new("breadcrumbs")
    component_without_stub_file =
      MountainView::Component.new("social_media_icons")
    component_with_stubs_but_old_syntax =
      MountainView::Component.new("card")

    assert_equal true, component_with_correct_stubs.stubs_correct_format?
    assert_equal false, component_without_stub_file.stubs_correct_format?
    assert_equal false, component_with_empty_stub_file.stubs_correct_format?
    assert_equal true, component_with_stubs_but_old_syntax.
      stubs_correct_format?
  end

  def test_stubs_file
    component = MountainView::Component.new("header")

    expected_stubs_file = Rails.root.join("app/components/header/header.yml")
    assert_equal expected_stubs_file, component.stubs_file
  end

  def test_stubs?
    component_with_stubs = MountainView::Component.new("header")
    component_without_stub_file = MountainView::Component.new("social_media_icons")
    component_with_empty_stub_file = MountainView::Component.new("breadcrumbs")

    assert_equal true, component_with_stubs.stubs?
    assert_equal false, component_without_stub_file.stubs?
    assert_equal false, component_with_empty_stub_file.stubs?
  end

  def test_example_title
    component = MountainView::Component.new("meta_header")
    component.component_stubs.each_with_index do | component_properties, index |
      if index.eql?(0)
        assert_equal "Specific Example",
                     component.example_title(component_properties, index)
      else
        built_title = component.title + " " + (index + 1).to_s
        assert_equal built_title,
                     component.example_title(component_properties, index)
      end
    end
  end

  def test_example_description
    component = MountainView::Component.new("meta_header")
    component.component_stubs.each_with_index do |component_properties, index|
      if index.eql?(0)
        assert_equal "This describes the use of this specific settings for "\
                         "the component",
                     component.example_description(component_properties)
      else
        assert_nil component.example_description(component_properties)
      end
    end
  end

  def test_example_classes
    component = MountainView::Component.new("meta_header")
    component.component_stubs.each_with_index do |component_properties, index|
      if index.eql?(0)
        assert_equal "mv--black-background",
                     component.example_classes(component_properties)
      else
        assert_nil component.example_classes(component_properties)
      end
    end
  end

  def test_remove_example_meta_properties
    component = MountainView::Component.new("meta_header")
    component.component_stubs.each do |component_properties|
      test_properties =
        component.remove_example_meta_properties component_properties
      refute test_properties[:mv_title]
      refute test_properties[:mv_description]
      refute test_properties[:mv_classes]
    end
  end
end

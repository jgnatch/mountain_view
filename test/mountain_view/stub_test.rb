# frozen_string_literal: true

require 'test_helper'
class MountainViewStubTest < ActiveSupport::TestCase
  def test_meta_title
    test_object = stub_to_test

    assert_equal header_stub_meta[:stubs][0][:mv_stub_meta][:title],
                 test_object[0].meta_title('Header', 0),
                 'Stub Meta Title not found'
    assert_equal 'Header 2',
                 test_object[1].meta_title('Header', 1),
                 'Stub Meta Title default not set'
  end

  def test_meta_description
    test_object = stub_to_test
    assert_equal header_stub_meta[:stubs][0][:mv_stub_meta][:description],
                 test_object[0].meta_description,
                 'Stub Meta Description not found'
    assert_nil test_object[1].meta_description,
               'nil not set for stub meta without description'
  end

  def test_meta_classes
    test_object = stub_to_test
    assert_equal header_stub_meta[:stubs][0][:mv_stub_meta][:classes],
                 test_object[0].meta_classes,
                 'Stub Meta Classes not found'
    assert_nil test_object[1].meta_classes,
               'nil not set for stub meta without classes'
  end

  def test_meta_partial
    test_object = stub_to_test
    assert_equal header_stub_meta[:stubs][0][:mv_stub_meta][:partial],
                 test_object[0].meta_partial,
                 'Stub Partial not found'
    assert_nil test_object[1].meta_partial,
               'nil not set for stub meta without partial'
  end

  def test_properties
    test_object = stub_to_test
    assert_equal header_stub_meta[:stubs][0].except(:mv_stub_meta),
                 test_object[0].properties,
                 'Properties did not correctly return with stub meta data'
    assert_equal header_stub_meta[:stubs][1],
                 test_object[1].properties,
                 'Properties did not correctly return without stub meta data'
  end

  private

  def stub_to_test
    MountainView::Component.new('header').component_stubs
  end
end

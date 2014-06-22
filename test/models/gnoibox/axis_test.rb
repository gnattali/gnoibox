require 'test_helper'

class AxisTest < ActiveSupport::TestCase
  test "axis type address" do
    item = items_with_tag(:shimizu_seizaburo)
    assert_equal 1, Gnoibox::Box::Sakagura.tagged_with(:mie).count, 'prefecture tag not assigned'
  end
end

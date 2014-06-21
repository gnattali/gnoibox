require 'test_helper'
 
class AxisTest < ActiveSupport::TestCase
  fixtures :all

  test "axis type address" do
    # assert_equal 1, Gnoibox::Box::Sakagura.items.count
    p Gnoibox::Item.all
    # p gnoibox_items(:testest)
  end
end

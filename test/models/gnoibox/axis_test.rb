require 'test_helper'

class AxisTest < ActiveSupport::TestCase

  test 'axis type equal' do
    zaku = items_with_tag(:zaku)
    assert_equal ['junmai'], zaku.tag_list_on(:category)
  end

  test 'axis type age' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal ['in_5year','in_10year'], shinjuku.tag_list_on(:age)
  end

  test 'axis type free' do
    zaku = items_with_tag(:zaku)
    assert Gnoibox::Box::Sake.tagged_with('作').include?(zaku)
    assert_equal ['原酒','直汲み'], zaku.tag_list_on(:free_tag)
  end

  test 'axis type month' do
    
  end

  test 'axis type prefecture' do
    item = items_with_tag(:daikanyama_tower)
    assert_equal ['tokyo'], item.tag_list_on(:prefecture)
  end

  test 'axis type range' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal ['from100k_to200k'], shinjuku.tag_list_on(:price_range)
    assert_equal ['in_5minutes', 'in_10minutes'], shinjuku.tag_list_on(:walk)
  end
  
  test 'axis type inclusion' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal ['3ldk'], shinjuku.tag_list_on(:floor_plan)
  end

  test 'axis type railway' do
    
  end
  
  test 'axis type station' do
    
  end

  test 'multiple value and tag for one column' do
    daikanyama = items_with_tag(:daikanyama_tower)
    assert daikanyama.tag_list_on(:preference)==["pet_ok", "designers"]
  end

  test "two axis(prefecture and city) for one column(address column)" do
    item = items_with_tag(:shimizu_seizaburo)
    assert_equal ['mie'], item.tag_list_on(:prefecture)
    assert_equal ['city_suzuka_shi'], item.tag_list_on(:city)
  end
  
  test "one axis for plural column" do

  end
end

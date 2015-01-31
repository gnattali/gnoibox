require 'test_helper'

class AxisTest < ActiveSupport::TestCase

  test 'axis type equal' do
    zaku = items_with_tag(:zaku)
    assert_equal ['junmai'], zaku.tag_list_on(:category)
  end

  test 'axis type age' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal ['in_5year','in_10year'], shinjuku.tag_list_on(:age)
    
    shinjuku.content.age = 1.year.ago.strftime "%Y-%m-%d"
    shinjuku.set_tags_from_content
    assert_equal ['in_3year', 'in_5year','in_10year'], shinjuku.tag_list_on(:age)
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
    #float range
    assert_equal ['from60_to65'], shinjuku.tag_list_on(:floor_space)
  end
  
  test 'axis type group' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal ['3ldk'], shinjuku.tag_list_on(:floor_plan)
  end

  test 'axis type railway' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal ['marunochi_line'], shinjuku.tag_list_on(:railway)
  end
  
  test 'axis type station' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal ['nishishinjuku_station'], shinjuku.tag_list_on(:station)
  end

  test 'axis type station with irregular railway_id' do
    matsudo = items_with_tag(:matsudo_park)
    assert_equal ['matsudo_station'], matsudo.tag_list_on(:station)
    assert_equal ['joban_line'], matsudo.tag_list_on(:railway)
  end

  test 'axis type town' do
    daikanyama = items_with_tag(:daikanyama_tower)
    shinjuku = items_with_tag(:shinjuku_tower)
    matsudo = items_with_tag(:matsudo_park)

    # assert_equal ['shibuya_ku_uguisudanichou'], daikanyama.tag_list_on(:town)
    # assert_equal ['shinjuku_ku_nishishinjuku'], shinjuku.tag_list_on(:town)
    # assert_equal ['matsudo_shi_matsudo'], matsudo.tag_list_on(:town)
    assert_equal ['渋谷区鶯谷町'], daikanyama.tag_list_on(:town)
    assert_equal ['新宿区西新宿'], shinjuku.tag_list_on(:town)
    assert_equal ['松戸市松戸'], matsudo.tag_list_on(:town)
  end
  
  test 'multiple value and tag for one column' do
    daikanyama = items_with_tag(:daikanyama_tower)
    assert daikanyama.tag_list_on(:preference)==["pet_ok", "designers"]
  end

  test "two axis(prefecture and city) for one column(address column)" do
    item = items_with_tag(:shimizu_seizaburo)
    assert_equal ['mie'], item.tag_list_on(:prefecture)
    assert_equal ['suzuka_shi'], item.tag_list_on(:city)

    multi_address_kura = items_with_tag(:multi_address_kura)
    assert_equal ['tokyo', 'chiba'].to_set, multi_address_kura.tag_list_on(:prefecture).to_set
    assert_equal ['setagaya_ku', 'ichikawa_shi'].to_set, multi_address_kura.tag_list_on(:city).to_set
  end
  
  test "one axis for plural column" do

  end
end

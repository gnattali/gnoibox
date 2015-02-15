require 'test_helper'

class ColumnTest < ActiveSupport::TestCase

  test 'text column' do
    shinjuku = items_with_tag(:matsudo_park)

    assert_equal "40戸", shinjuku.content.number_of_rooms.text_with_unit
  end

  test 'number column' do
    Gnoibox::Box::Building.set_order_key(:rent)
    shinjuku = items_with_tag(:shinjuku_tower)
    daikanyama = items_with_tag(:daikanyama_tower)

    assert shinjuku.order_value < daikanyama.order_value
    assert_equal "200,000円", shinjuku.content.rent.text_with_unit
  end
  
  test 'float column' do
    Gnoibox::Box::Building.set_order_key(:floor_space)
    shinjuku = items_with_tag(:shinjuku_tower)
    daikanyama = items_with_tag(:daikanyama_tower)

    assert shinjuku.order_value > daikanyama.order_value
    assert_equal "63.5㎡", shinjuku.content.floor_space.text_with_unit
  end

  test 'station column' do
    shinjuku = items_with_tag(:shinjuku_tower)
    assert_equal "東京メトロ丸ノ内線 西新宿駅", shinjuku.content.station1.to_s
    shinjuku.content.station1 = "2600102"
    assert_equal "東急東横線 代官山駅", shinjuku.content.station1.to_s
  end

end

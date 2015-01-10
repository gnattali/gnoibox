require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  
  test 'associated_tags' do
    shinjuku = items_with_tag(:shinjuku_tower)
    daikanyama = items_with_tag(:daikanyama_tower)

    tags = Gnoibox::Box::Building.items.where(url: "daikanyama_tower").associated_tags
    assert_equal [:shibuya_ku], tags[:city]

    tags = Gnoibox::Box::Building.items.associated_tags
    assert_equal [:shibuya_ku, :shinjuku_ku].to_set, tags[:city].to_set
  end

  test 'associated_tags_on specific context' do
    shinjuku = items_with_tag(:shinjuku_tower)
    daikanyama = items_with_tag(:daikanyama_tower)
    
    assert_equal [:shibuya_ku], Gnoibox::Box::Building.items.where(url: "daikanyama_tower").associated_tags_on(:city)
    assert_equal [:shibuya_ku, :shinjuku_ku].to_set, Gnoibox::Box::Building.items.associated_tags_on(:city).to_set
  end

  test 'keyword search' do
    shinjuku = items_with_tag(:shinjuku_tower)

    assert_equal ["daikanyama_tower"], Gnoibox::Box::Building.items.search_with("代官山").map(&:url)
    assert_equal ["shinjuku_tower"], Gnoibox::Box::Building.items.search_with(:shinjuku_ku).map(&:url)
  end
end

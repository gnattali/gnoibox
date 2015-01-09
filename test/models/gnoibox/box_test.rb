require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  
  test 'links_for' do
    shinjuku = items_with_tag(:shinjuku_tower)
    daikanyama = items_with_tag(:daikanyama_tower)

    available_on_facet = Gnoibox::Box::Building.items.associated_tags_on(:city)
    assert_equal [[:shinjuku_ku], [:shibuya_ku]].to_set, Gnoibox::Box::Building.links_for(:city, available_on_facet).map(&:tags).to_set
    assert_equal [[],[:shibuya_ku]].to_set, Gnoibox::Box::Building.links_for(:city, available_on_facet, [:shinjuku_ku]).map(&:tags).to_set
  end
end

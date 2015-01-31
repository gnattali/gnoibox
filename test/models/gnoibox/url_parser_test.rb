require 'test_helper'

class UrlParserTest < ActiveSupport::TestCase

  test 'root top' do
    page = Gnoibox::UrlParser.new({})
    assert_equal :root, page.box.key
    assert_equal "トップページ", page.title
    
    items(:root_page).update_column(:status, "draft")
    page = Gnoibox::UrlParser.new({})
    assert_equal "root page title from yml", page.title
  end

  test 'axis collection' do
    daikanyama = items_with_tag(:daikanyama_tower)
    shinjuku = items_with_tag(:shinjuku_tower)

    page = Gnoibox::UrlParser.new({first: 'building', second: 'shibuya_ku'})
    assert_equal :building, page.box.key
    assert_equal 1, page.items.count
    assert_equal '渋谷区の物件一覧(from facet item)', page.title
    assert_equal 3, page.bread_crumbs.count
    assert_equal "/building/shibuya_ku", page.bread_crumbs.last[0]
    assert_equal [:shibuya_ku, :shinjuku_ku].to_set, page.options_for(:city).to_set, "should include tags of shinjuku building which is not in search result"
    assert_equal [:pet_ok, :designers].to_set, page.options_for(:preference).to_set
    assert_equal [[:shinjuku_ku], []].to_set, page.links_for(:city).map(&:tags).to_set

    page = Gnoibox::UrlParser.new({first: 'building', second: 'pet_ok'})
    assert_equal [:shibuya_ku].to_set, page.options_for(:city).to_set
    assert_equal [:pet_ok, :designers].to_set, page.options_for(:preference).to_set, "should not include tags of shinjuku because preference is allowed to cross search in axis"
    assert_equal [[:pet_ok, :designers], []].to_set, page.links_for(:preference).map(&:tags).to_set
  end
  
  test 'box item' do
    
  end

  test 'box top' do
    daikanyama = items_with_tag(:daikanyama_tower)
    shinjuku = items_with_tag(:shinjuku_tower)
    matsudo = items_with_tag(:matsudo_park)
    page = Gnoibox::UrlParser.new({first: 'building'})
    assert_equal 3, page.items.count
    assert_equal [:shibuya_ku, :shinjuku_ku, :matsudo_shi].to_set, page.options_for(:city).to_set
  end
  
  test 'root item' do
    
  end
  
end

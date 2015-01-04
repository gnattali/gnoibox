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
    page = Gnoibox::UrlParser.new({first: 'building', second: 'city_shibuya_ku'})
    assert_equal :building, page.box.key
    assert_equal 1, page.items.count
    assert_equal '渋谷区の物件一覧(from facet item)', page.title
    assert_equal 3, page.bread_crumbs.count
    assert_equal "/building/city_shibuya_ku", page.bread_crumbs.last[0]
  end
  
  test 'box item' do
    
  end

  test 'box top' do
    daikanyama = items_with_tag(:daikanyama_tower)
    shinjuku = items_with_tag(:shinjuku_tower)
    page = Gnoibox::UrlParser.new({first: 'building'})
    assert_equal 2, page.items.count
  end
  
  test 'root item' do
    
  end
  
end

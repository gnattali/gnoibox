class Gnoibox::SiteController < ApplicationController
  def index
    @page = Gnoibox::UrlParser.new(params)
    render @page.view_file
  end

private
  helper_method :box, :items, :item, :tags, :resource_type

  def box
    @page.box
  end

  def items
    @page.items
  end

  def item
    @page.item
  end

  def tags
    @page.tags
  end

  def resource_type
    @page.resource_type
  end
end

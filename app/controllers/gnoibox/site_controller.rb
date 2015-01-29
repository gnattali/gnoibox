class Gnoibox::SiteController < ApplicationController
  include Gnoibox::ApplicationHelper

  def index
    @page = Gnoibox::UrlParser.new(params)
    respond_to do |format|
      format.html{ render @page.view_file, layout: @page.layout }
      format.json do
        render json: {items: @page.items, facet_item: @page.facet_item} if @page.items.present?
        render json: {item: @page.item} if @page.item.present?
      end
    end
  end
  
  def search
    @items = Gnoibox::Item.published.order(published_at: :desc).search_with(params[:q])
  end
  
  def create_inquiry
    @page = Gnoibox::UrlParser.new(params)
    
    if inquiry(inquiry_params).save_and_notify(@page)
      redirect_to gnb_thanks_path(first: params[:first], second: params[:second], third: params[:third])
    else
      render @page.view_file, layout: @page.layout
    end
  end
  
  def thanks
    @page = Gnoibox::UrlParser.new(params)
    
    render @page.thanks_view, layout: @page.layout
  end

private
  attr_reader :page
  helper_method :page, :inquiry
  helper_method :box, :items, :item, :tags, :facet_item, :form, :form_partial, :resource_type, :bread_crumbs, :link_axes
  delegate :box, :items, :item, :tags, :facet_item, :form, :form_partial, :resource_type, :bread_crumbs, :link_axes, to: :page

  def inquiry(inq_params={})
    @inquiry ||= form.new_inquiry(inq_params)
  end

  def inquiry_params
    params[:inquiry].permit!
  end
end

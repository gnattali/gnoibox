class Gnoibox::SiteController < ApplicationController
  def index
    @page = Gnoibox::UrlParser.new(params)
    render @page.view_file, layout: @page.layout
  end
  
  def create_inquiry
    @page = Gnoibox::UrlParser.new(params)
    
    if inquiry(inquiry_params).save
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
  helper_method :box, :items, :item, :tags, :form, :inquiry, :resource_type

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

  def form
    @page.form
  end
  
  def inquiry(inq_params={})
    @inquiry ||= form.new_inquiry(inq_params)
  end

  def resource_type
    @page.resource_type
  end

  def inquiry_params
    params[:inquiry].permit!
  end
end

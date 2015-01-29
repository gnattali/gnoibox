module Gnoibox
  class UrlParser
    TAG_DELIMITER = '-'

    BOX_KEYS = Gnoibox::BoxCollection.keys
    AXIS_OPTION_KEYS = Gnoibox::AxisCollection.option_keys
    AXIS_OPTION_KEYS_TO_S = AXIS_OPTION_KEYS.map(&:to_s)
    RESERVED_KEYS = [:gnoibox, :admin, :thanks, :root, :my, :facet, :box, :axis, :block, :item, :column, :form, :inquiry, :site, :search, :s]

    def self.existing_tags
      ActsAsTaggableOn::Tag.pluck(:name)
    end

    def self.all_keys_and_tags
      (BOX_KEYS + AXIS_OPTION_KEYS + RESERVED_KEYS + UrlParser.existing_tags).map(&:to_s).uniq
    end

    attr_reader :box, :item, :base_relation, :items, :category, :facet_item, :sub_facet, :resource_type, :params, :first, :second, :third

    def initialize(url_params)
      @first = url_params[:first].try(:to_sym)
      @second = url_params[:second].try(:to_sym)
      @third = url_params[:third]
      @params = url_params

      parse
    end

    def layout
      @layout ||= box.layout(self)
    end

    def view_file
      @view_file ||= (item.try(:view_file).presence || box.send("#{resource_type}_view", self))
    end

    def title
      @title ||= item ? item.title : box.title(self)
    end
    def description
      @description ||= item ? item.description : box.description(self)
    end
    def keywords
      @keywords ||= item ? item.keywords : box.keywords(self)
    end
    def og_image
      @og_image ||= item ? item.og_image : box.og_image(self)
    end
    def og_type
      @og_type ||= item ? item.og_type : box.og_type(self)
    end

    def tag_keys
      @tag_keys ||= Array(second) + (third.to_s || '').split(TAG_DELIMITER).map(&:to_sym)
    end

    def tag_hash
      @tag_hash ||= box.tag_hash.select{|k, v| tag_keys.include? k.to_sym}
    end
    
    def tags
      @tags ||= tag_keys.map{|t| tag_hash[t.to_sym]}.compact
    end

    def form
      @form ||= box.form_class(self)
    end
    
    def form_partial
      @form_partial ||= form.view_file(self)
    end
    
    def thanks_view
      @thanks_view ||= form.thanks_view(self)
    end

    def facet_keys
      if third
        ["#{first}/#{second}/#{third}", "#{second}/#{third}", third]
      elsif second
        ["#{first}/#{second}", second]
      else
        [(first || 'root')]
      end
    end

    def i18n(type, k=nil)
      facet_keys.detect do |key|
        r = I18n.t("gnoibox.#{type}.#{key}", default: "").presence
        break r if r
      end
    end

    def bread_crumbs
      if resource_type==:collection
        crumbs = [ ["/", "TOP"], ["/#{box.key}", box.label] ]
        crumbs.push( ["/#{box.key}/#{second}", (box.tag_hash[second.to_sym].try(:label) || second) ] ) if second
        crumbs.push( ["/#{box.key}/#{second}/#{third}", third.split(TAG_DELIMITER).map{|t| box.tag_hash[t.to_sym].try(:label) || t}.join(',') ] ) if third
        crumbs
      elsif resource_type==:member
        path = ""
        crumbs = [ ["/", "TOP"] ]
        if box.key==:root
          crumbs.push( [(path += "/#{first}"), item.title] )
        else
          crumbs.push( [(path += "/#{box.key}"), box.label] ) 
          crumbs.push( [(path += "/#{second}"), item.title] )
        end
      end
    end

    def items
      @items ||= base_relation.default_ordered.page(params[:page]).per(box.limit) if base_relation
    end

    def selected_tags_in(facet)
      Gnoibox::AxisCollection.find(facet.to_sym).option_keys & tag_keys
    end
    
    def tags_in_searched_items
      @tags_in_searched_items ||= base_relation.associated_tags
    end
    
    def options_for(facet)
      facet = facet.to_sym
      return tags_in_searched_items[facet] if @on_box_top || Gnoibox::AxisCollection.find(facet).allowed_to_cross_search_in_axis || selected_tags_in(facet).blank?
      
      other_tags = tag_keys - selected_tags_in(facet)
      altered_relation = box.published_items
      altered_relation = altered_relation.tagged_with(other_tags) if other_tags.present?
      altered_relation.associated_tags_on(facet)
    end
    
    def links_for(facet)
      available_on_facet = options_for(facet)
      return [] if available_on_facet.blank?
      box.links_for(facet, available_on_facet, tag_keys)
    end
    
    def link_axes
      box.axis_list.map{|axis| Gnoibox::Box::AxisLinks.new axis.key, axis.label, links_for(axis.key), axis.allowed_to_cross_search_in_axis}.index_by(&:axis_key)
    end

  private
    ROOT_TOP = ->(params){ !params[:first] }
    AXIS_COLLECTION = ->(params){
      params[:third] ||
      (
        params[:second] &&
        ( AXIS_OPTION_KEYS.include?(params[:second].try(:to_sym)) || UrlParser.existing_tags.include?(params[:second]) )
      )
    }
    BOX_ITEM = ->(params){ params[:second] && BOX_KEYS.include?(params[:first].to_sym) }
    BOX_TOP = ->(params){ BOX_KEYS.include?(params[:first].to_sym) }

    def parse
      case params
      when ROOT_TOP then root_top
      when AXIS_COLLECTION then axis_collection
      when BOX_ITEM then box_item
      when BOX_TOP then box_top
      else root_item
      end
    end

    def root_top
      @resource_type = :collection
      @box = Gnoibox::BoxCollection.find(:root)
      @item = box.find_published_item('index')
    end

    def axis_collection
      @resource_type = :collection
      @box = Gnoibox::BoxCollection.find(first)
      @category = second
      @facet_item = Gnoibox::Box::Facet.find_published_item(facet_keys.first)
      @base_relation = box.published_items.tagged_with(tag_keys)
      @base_relation = @base_relation.search_with(params[:q]) if params[:q]
    end

    def box_item
      @resource_type = :member
      @box = Gnoibox::BoxCollection.find(first)
      @item = box.find_published_item(second)
    end

    def box_top
      @resource_type = :collection
      @box = Gnoibox::BoxCollection.find(first)
      @facet_item = box.facet_item
      @on_box_top = true
      @base_relation = box.published_items
      @base_relation = @base_relation.search_with(params[:q]) if params[:q]
    end

    def root_item
      @resource_type = :member
      @box = Gnoibox::BoxCollection.find(:root)
      @item = box.find_published_item(first)
      unless item
        @view_file = first
        @item = box.new_item
      end
    end

  end
end

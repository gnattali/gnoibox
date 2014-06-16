module Gnoibox
  class UrlParser
    TAG_DELIMITER = '-'

    BOX_KEYS = Gnoibox::BoxCollection.keys
    AXIS_OPTION_KEYS = Gnoibox::AxisCollection.option_keys
    RESERVED_KEYS = [:gnoibox, :admin, :thanks, :root, :my, :facet, :box, :axis, :block, :item, :column, :form, :inquiry, :site]

    def self.existing_tags
      ActsAsTaggableOn::Tag.pluck(:name)
    end

    def self.all_keys_and_tags
      (BOX_KEYS + AXIS_OPTION_KEYS + RESERVED_KEYS + UrlParser.existing_tags).map(&:to_s).uniq
    end


    attr_reader :box, :item, :items, :category, :facet_item, :sub_facet, :resource_type, :params, :first, :second, :third

    def initialize(params)
      @first = params[:first].try(:to_sym)
      @second = params[:second].try(:to_sym)
      @third = params[:third]
      @params = params

      parse
    end

    def layout
      @layout ||= @box.layout(self)
    end

    def view_file
      @view_file ||= (@item.try(:view_file).presence || @box.send("#{resource_type}_view", self))
    end

    def title
      @title ||= @item ? @item.title : @box.title(self)
    end
    def description
      @description ||= @item ? @item.description : @box.description(self)
    end
    def keywords
      @keywords ||= @item ? @item.keywords : @box.keywords(self)
    end

    def tag_keys
      @tag_keys ||= Array(@second.to_s) + (@third.to_s || '').split(TAG_DELIMITER)
    end

    def tag_hash
      @tag_hash ||= @box.tag_hash.select{|k, v| tag_keys.include? k.to_s}
    end
    
    def tags
      @tags ||= tag_keys.map{|t| tag_hash[t.to_sym]}
    end

    def form
      @form ||= @box.form_class(self)
    end
    
    def form_partial
      @form_partial ||= form.view_file(self)
    end
    
    def thanks_view
      @thanks_view ||= form.thanks_view(self)
    end

    def facet_keys
      if @third
        ["#{first}/#{second}/#{third}", "#{second}/#{third}", third]
      elsif @second
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
      case @params
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
    end

    def axis_collection
      @resource_type = :collection
      @box = Gnoibox::BoxCollection.find(@first)
      @category = @second
      @facet_item = Gnoibox::Box::Facet.find_item(facet_keys.first)
      @items = @box.tagged_with(tag_keys).page(@params[:page]).per(@box.limit)
    end

    def box_item
      @resource_type = :member
      @box = Gnoibox::BoxCollection.find(@first)
      @item = @box.find_item(@second)
    end

    def box_top
      @resource_type = :collection
      @box = Gnoibox::BoxCollection.find(@first)
      @facet_item = @box.facet_item
      @items = @box.items.page(@params[:page]).per(@box.limit)
    end

    def root_item
      @resource_type = :member
      @box = Gnoibox::BoxCollection.find(:root)
      @item = @box.find_item(@first)
      unless @item
        @view_file = @first
        @item = @box.new_item
      end
    end

  end
end

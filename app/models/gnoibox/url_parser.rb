module Gnoibox
  class UrlParser
    TAG_DELIMITER = '-'

    BOX_KEYS = Gnoibox::BoxCollection.keys
    AXIS_OPTION_KEYS = Gnoibox::AxisCollection.option_keys
    RESERVED_KEYS = [:gnoibox, :admin, :thanks]

    def self.existing_tags
      ActsAsTaggableOn::Tag.pluck(:name)
    end

    def self.all_keys_and_tags
      (BOX_KEYS + AXIS_OPTION_KEYS + RESERVED_KEYS + UrlParser.existing_tags).map(&:to_s).uniq
    end

    attr_reader :box, :item, :items, :tags, :category, :resource_type, :params

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

    def tag_hash
      @tag_hash ||= @box.tag_hash.select{|k, v| axis_tags.include? k.to_s}
    end

    def form
      @form ||= @box.form_class(self)
    end
    
    def thanks_view
      @thanks_view ||= form.thanks_view(self)
    end

    def axis_item
      @axis_item ||= @box.axis_item(self)
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
      @items = @box.tagged_with(axis_tags).page(@params[:page]).per(@box.limit)
    end
    def axis_tags
      @tags ||= Array(@second.to_s) + (@third.to_s || '').split(TAG_DELIMITER)
    end

    def box_item
      @resource_type = :member
      @box = Gnoibox::BoxCollection.find(@first)
      @item = @box.find_item(@second)
    end

    def box_top
      @resource_type = :collection
      @box = Gnoibox::BoxCollection.find(@first)
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

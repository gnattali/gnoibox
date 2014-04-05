module Gnoibox
  class Item < ActiveRecord::Base
    include ColumnHoldable

    self.table_name= :gnoibox_items

    validates :url, presence: true, exclusion: {in: lambda{|record| UrlParser.all_keys_and_tags} }, uniqueness: true

    acts_as_taggable
    mount_uploader :main_image, MainImageUploader

    def set_content
      set_tags_from_content
      # write_attribute :content, content.to_json
      super
    end

    def set_tags_from_content
      content.cols.each do |col|
        set_tag_list_on(col.axis.key, col.tag_list) if col.axis
      end
    end
    
    def box
      @box ||= self.class.box
    end

    def order_value_from(attr)
      v = send(attr)
      v.is_a?(Integer) ? ("%050d" % v) : v.to_s
    end

    def cache_order_value
      self.order_value = respond_to?(box.order_key) ? order_value_from(box.order_key) : content.try(box.order_key).try(:to_order_value)
    end

    def update(args)
      assign_attributes(args)
      cache_order_value
      save
      self
    end
    
    class << self
      attr_reader :view_file_options

      def set_view_file_options(options=nil)
        @view_file_options = options
      end

      def set_box(box)
        @box = box
        @box.set_item_class = self
      end

      def box
        @box ||= self.name.sub('Item::', 'Box::').constantize
      end
      
    end

  end

end

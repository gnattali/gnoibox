module Gnoibox
  class Item < ActiveRecord::Base
    include ColumnHoldable

    self.table_name= :gnoibox_items

    validates :url, presence: true, exclusion: {in: lambda{|record| record.box_key.to_s=='facet' ? [] : UrlParser.all_keys_and_tags} }, uniqueness: true

    acts_as_taggable
    mount_uploader :main_image, MainImageUploader

    belongs_to :author_profile, foreign_key: :gnoibox_author_id

    def set_content
      set_tags_from_content
      # write_attribute :content, content.to_json
      super
    end

    def grouped_tags_for_content
      #allow duplicate axis like station1, station2
      content.cols.map(&:tag_list).compact.reduce({}) do |memo, tag_group|
        tag_group.each do |k,v|
          memo[k] ||= []
          memo[k] += v
        end
        memo
      end
    end

    def set_tags_from_content
      grouped_tags_for_content.each do |k, vals|
        set_tag_list_on(k, vals)
      end
    end
    
    def box
      self.class.box
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

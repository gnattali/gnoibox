module Gnoibox
  class Box
    class << self
      attr_reader :key, :label, :layout, :member_view, :collection_view, :description, :keywords

      def set_key(key, label)
        Gnoibox::BoxCollection.add self
        @key = key.to_sym
        @label = label
      end

      def set_layout(v) @layout=v end
      def set_member_view(v) @member_view=v end
      def set_collection_view(v) @collection_view=v end
      def set_description(v) @description=v end
      def set_keywords(v) @keywords=v end
      def set_position(v) @position=v end
      def position() @position ||= 999 end
      def set_list_cols(cols) @list_cols = cols end
      def list_cols() @list_cols ||= [] end
      def set_omit_cols(cols) @omit_cols = cols end
      def omit_cols() @omit_cols ||= [] end

      def set_item_class(v) @item_class=v end
      def item_class
        @item_class ||= self.name.sub('Box::', 'Item::').constantize
      end
      def item_cols
        @item_cols ||= item_class.col_classes
      end
      def item_col(name)
        item_cols.detect{|col| col.name==name }
      end

      def to_param() @key end

      def new_item(args={})
        item_class.new args.merge({box_key: key})
      end

      def find_item(key)
        item_class.find_by(url: key)
        # key=~/\D/ ? item_class.find_by(url: key) : item_class.find(key)
      end

      def items
        item_class.where(box_key: key)
      end

      def tagged_with(tags)
        item_class.where(box_key: key).tagged_with(tags)
      end

      #can be overridden

      def limit() 20 end

      def member_view(url_parser)
        @member_view
      end

      def collection_view(url_parser)
        @collection_view
      end

    end
  end
end

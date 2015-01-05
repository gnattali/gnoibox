module Gnoibox
  class Form
    class << self
      attr_reader :key, :label, :view_file

      def set_key(key, label)
        Gnoibox::FormCollection.add self
        @key = key.to_sym
        @label = label
      end

      def set_view_file(v) @view_file=v end
      def set_thanks_view(v) @thanks_view=v end
      def set_list_cols(cols) @list_cols = cols end
      def list_cols() @list_cols ||= [] end

      def set_inquiry_class(v) @inquiry_class=v end
      def inquiry_class
        @inquiry_class ||= self.name.sub('Form::', 'Inquiry::').constantize
      end
      def inquiry_cols
        @inquiry_cols ||= inquiry_class.col_classes
      end
      def inquiry_col(name)
        inquiry_cols.detect{|col| col.name==name }
      end

      def to_param() @key end

      def new_inquiry(args={})
        inquiry_class.new args.merge({form_key: key})
      end
      
      # def create_inquiry(args)
      #   inquiry = new_inquiry(args)
      #   inquiry.save
      #   inquiry
      # end
      
      def find_inquiry(id)
        inquiry_class.find(id)
      end

      def inquiries
        inquiry_class.where(form_key: key)
      end

      #can be overridden

      def limit() 20 end

      def view_file(url_parser)
        @view_file ||= 'gnoibox/forms/new'
      end
      
      def thanks_view(url_parser)
        @thanks_view ||= 'gnoibox/forms/thanks'
      end

    end
  end
end

module Gnoibox
  class Item < ActiveRecord::Base
    include ColumnHoldable

    self.table_name= :gnoibox_items

    validates :url, presence: true, exclusion: {in: lambda{|record| UrlParser.all_keys_and_tags} }, uniqueness: true

    acts_as_taggable
    mount_uploader :main_image, MainImageUploader

    # def content
    #   @content ||= self.class.content_class.new(JSON.parse(read_attribute(:content).presence || '{}'))
    # end

    # def content=(attrs)
    #   content.set_attributes(attrs)
    #   set_content
    # end

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

      # def content_class
      #   @content_class ||= Class.new do
      #     attr_reader :cols
      #     def initialize(attributes)
      #       @cols = self.class.col_classes.map do |col_class|
      #         col_class.new(attributes[col_class.name.to_s])
      #       end
      #     end

      #     def col_hash
      #       @col_hash ||= cols.index_by{|col| col.name }
      #     end

      #     def set_attributes(attrs)
      #       attrs.each{|key, value| send("#{key}=", value) }
      #     end

      #     def to_h
      #       Hash[cols.map{|col| [col.name, col.value] }]
      #     end

      #     def to_json
      #       to_h.to_json
      #     end

      #     class << self
      #       def col_classes
      #         @col_classes ||= []
      #       end
      #     end
      #   end
      # end

      # def col_classes
      #   content_class.col_classes
      # end

      # def col(name, type, label, settings={})
      #   c_class = content_class
      #   content_class.col_classes << Class.new(column_class(type)) do
      #     self.name = name
      #     self.type = type
      #     self.label = label
      #     self.settings = settings
      #     self.setup(settings)
      #     self.set_delegator(c_class)
      #   end

      #   # content_class.class_exec do
      #   #   define_method name do
      #   #     col_hash[name]
      #   #   end
      #   #   define_method "#{name}=" do |v|
      #   #     col_hash[name].set_value(v)
      #   #   end
      #   # end
      # end

      # private

      # def column_class(type)
      #   "Gnoibox::Column::#{type.to_s.camelize}".constantize
      # end

    end

  end

end
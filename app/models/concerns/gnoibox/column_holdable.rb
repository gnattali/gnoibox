module Gnoibox
  module ColumnHoldable
    extend ActiveSupport::Concern

    included do
    end


    def content
      @content ||= self.class.content_class.new(JSON.parse(read_attribute(:content).presence || '{}'))
    end

    def content=(attrs)
      content.set_attributes(attrs)
      set_content
    end

    def set_content
      write_attribute :content, content.to_json
    end


    module ClassMethods

      def content_class
        @content_class ||= Class.new do
          attr_reader :cols
          def initialize(attributes)
            @cols = self.class.col_classes.map do |col_class|
              col_class.new(attributes[col_class.name.to_s])
            end
          end

          def col_hash
            @col_hash ||= cols.index_by{|col| col.name }
          end

          def set_attributes(attrs)
            attrs.each{|key, value| send("#{key}=", value) }
          end

          def to_h
            Hash[cols.map{|col| [col.name, col.value] }]
          end

          def to_json
            to_h.to_json
          end

          class << self
            def col_classes
              @col_classes ||= []
            end
          end
        end
      end

      def col_classes
        content_class.col_classes
      end

      def col(name, type, label, settings={})
        c_class = content_class
        content_class.col_classes << Class.new(column_class(type)) do
          self.name = name
          self.type = type
          self.label = label
          self.settings = settings
          self.setup(settings)
          self.set_delegator(c_class)
        end

        # content_class.class_exec do
        #   define_method name do
        #     col_hash[name]
        #   end
        #   define_method "#{name}=" do |v|
        #     col_hash[name].set_value(v)
        #   end
        # end
      end

      private

      def column_class(type)
        "Gnoibox::Column::#{type.to_s.camelize}".constantize
      end

    end
  end
end
module Gnoibox
  module ColumnHoldable
    extend ActiveSupport::Concern

    included do
      delegate :cols, :col_hash, to: :content
      delegate :axes, to: :class
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

    def api_content_hash
      content.to_api_hash
    end
    
    def to_api_hash
      as_json.merge("content"=>api_content_hash)
    end

    module ClassMethods

      def set_col(name, type, label, settings={})
        raise 'third parameter for #set_col should be label' unless label.is_a? String

        holder_name = self.name
        c_class = content_class
        content_class.col_classes << Class.new(column_class(type)) do
          self.name = name
          self.type = type
          self.label = label
          self.settings = settings
          self.setup(settings)
          self.set_delegator(c_class)
          self.set_validator(c_class)
          self.set_axis(c_class)
          self.holder_name = holder_name
        end
      end

      def content_class
        @content_class ||= Class.new do
          include ActiveModel::Validations

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
            Hash[cols.map{|col| [col.name, col.value_to_serialize] }]
          end

          def to_json
            to_h.to_json
          end
          
          def to_api_hash
            Hash[cols.map{|col| [col.name, col.to_api_value] }]
          end

          class << self
            def name
              'Content'
            end
            
            def col_classes
              @col_classes ||= []
            end

            def axes
              @axes ||= []
            end
          end
        end
      end

      def col_classes
        content_class.col_classes
      end
      
      def axes
        content_class.axes
      end

      private

      def column_class(type)
        "Gnoibox::Column::#{type.to_s.camelize}".constantize
      end

    end
  end
end

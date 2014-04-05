module Gnoibox
  class Column
    attr_reader :value
    def initialize(value=nil)
      set_value value
    end

    def set_value(v)
      @value = v
    end

    def partial_name
      self.class.type
    end

    def to_s
      @value.to_s
    end
    alias_method :text, :to_s

    def to_order_value
      @value.to_s
    end

    def present?
      @value.to_s.present?
    end
    def presence
      @value.to_s.presence
    end

    def to_i
      @value.to_i
    end

    def tag_list
      Array(value).map{|v| axis.tag_for(v) }.flatten.compact if axis
    end

    def name
      self.class.name
    end
    def type
      self.class.type
    end
    def label
      self.class.label
    end
    def axis
      self.class.settings[:axis]
    end

    class << self
      attr_accessor :name, :type, :label, :settings

      def setup(settings)
      end

      def set_delegator(content_class)
        content_class.class_exec(name) do |name|
          define_method name do
            col_hash[name]
          end
          define_method "#{name}=" do |v|
            col_hash[name].set_value(v)
          end
        end
      end

    end
  end

  class Column
    class Text < Column
    end

    class TextArea < Column
    end

    class RichText < Column
    end

    class Select < Column
      include Gnoibox::ColumnSelectable
    end

    class Radio < Column
      include Gnoibox::ColumnSelectable
    end

    class CheckBox < Column
      include Gnoibox::ColumnSelectable
    end

    class Boolean < Column
      # def set_value(v)
      #   @value = (v=='true' ? true : false)
      # end

      def to_order_value
        @value ? 1 : 0
      end

    end

    class Number < Column
      include ActionView::Helpers::NumberHelper

      def set_value(v)
        @value = v.to_i
      end

      def to_order_value
        "%050d" % @value
      end

      def text
        number_with_delimiter(value).to_s
      end

      def unit
        self.class.settings[:unit]        
      end

      def text_with_unit
        text.to_s + unit.to_s
      end
    end

    class Image < Column
      extend CarrierWave::Mount

      class << self
        def setup(settings)
          self.class_exec(settings) do |settings|
            mount_uploader :image, (settings[:uploader] || Gnoibox::MainImageUploader)
            def read_uploader(column)
              # pp 'read_uploader'
              # pp value
              value
            end
            def write_uploader(column, identifier)
              # pp 'write_uploader'
              # pp identifier
              set_value identifier
            end
          end
        end

        def set_delegator(content_class)
          content_class.class_exec(name) do |name|
            define_method name do
              col_hash[name]
            end
            define_method "#{name}=" do |v|
              col_hash[name].image = v
              col_hash[name].image.store!
            end
            define_method "remove_#{name}" do
              col_hash[name].send "remove_image"
            end
            define_method "remove_#{name}=" do |v|
              col_hash[name].send "remove_image=", v
            end
            define_method "#{name}_cache" do
              col_hash[name].send "image_cache"
            end
          end
        end
      end

      def id
        name
      end

      def url
        image.url
      end
    end

    class Medium < Column
    end

    class Date < Column
      def set_value(v)
        @value = v.to_date
      end
    end

    class Address < Column
    end
  end
end

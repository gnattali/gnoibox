module Gnoibox
  class Column
    delegate :name, :type, :label, :settings, :axis, :axes, :main_axis, :required, to: :class

    attr_reader :value #value to be serialized and matched to tags, may be array
    def initialize(value=nil)
      set_value value
    end

    def set_value(v)
      @value = v
    end

    def value_list
      value.is_a?(Array) ? value : Array(value)
    end

    def partial_name
      self.class.type
    end

    def to_s
      @value.to_s
    end
    alias_method :text, :to_s
    
    def snip_display
      to_s
    end

    def to_order_value
      to_s
    end
    
    def value_to_serialize
      @value
    end

    def present?
      @value.to_s.present?
    end
    def presence
      @value.to_s.presence
    end
    def blank?
      !present?
    end
    
    def to_i
      @value.to_i
    end
    
    def axis_values
      value_list
    end

    def grouped_tags
      axes.map do |ax|
        [ax.key, axis_values.map{|v| ax.tag_for(v)}.flatten.compact ]
      end
    end

    def tag_list
      Hash[ grouped_tags ] if axis
    end
    
    class << self
      attr_accessor :name, :type, :label, :settings, :required

      def setup(settings)
      end
      
      def axis
        settings[:axis]
      end
      
      def axes
        Array(axis)
      end

      def main_axis
        axes.first
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
      
      def set_validator(content_class)
        return unless settings[:validates]
        content_class.class_exec(name, settings) do|name, settings|
          validates name, settings[:validates]
        end
        self.required = true if settings[:validates][:presence]
      end
      
      def set_axis(content_class)
        axes.each do |ax|
          content_class.axes.push(ax) unless content_class.axes.include?(ax)
        end
      end
    end
  end

  class Column
    class Text < Column
    end

    class TextArea < Column
      def snip_display
        to_s[0,40]
      end
    end

    class RichText < Column
      def snip_display
        ActionController::Base.helpers.strip_tags(to_s)[0,40]
      end
    end

    class Select < Column
      include Gnoibox::ColumnSelectable
    end

    class Radio < Column
      include Gnoibox::ColumnSelectable
    end

    class CheckBox < Column
      include Gnoibox::ColumnSelectable

      include Enumerable
      delegate :each, to: :value
      delegate :size, to: :value

      def set_value(v)
        @value = Array(v).reject(&:blank?)
      end

      def delimiter
        settings[:delimiter] || ','
      end

      def text_list
        value_list.map{|v| option_hash[v.to_sym]}
      end

      def to_s
        text_list.join(delimiter)
      end

    end
    
    class Parent < Column
      delegate :parent_class, to: :class
      def self.parent_class
        @parent_class ||= settings[:belongs_to]
      end

      # define belongs_to on column holder model

      def set_value(v)
        @parent_object = parent_class.find_item(v)
        @value = v
      end
      
    end
    
    # class Suggest < Column
    #   
    # end

    class FreeTag < Column
      def delimiter
        settings[:delimiter] || ','
      end

      def value_list
        value.is_a?(Array) ? value : Array( value.try(:split, delimiter) )
      end
      
      def to_s
        value_list.join(delimiter)
      end
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
        @value = v.present? ? v.to_i : nil
      end

      def to_order_value
        "%050d" % @value
      end

      def raw_number
        value
      end

      def to_s
        number_with_delimiter(value).to_s
      end
      alias_method :text, :to_s
      
      def unit
        self.class.settings[:unit]
      end

      def text_with_unit
        number_with_delimiter(value).to_s + unit.to_s
      end
    end

    class Float < Column

      def set_value(v)
        @value = v.present? ? v.to_f : nil
      end
      
      def to_order_value
        (@value.to_f * 1000000000000000000000000000000).to_i
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

      def set_value(v)
        if v.is_a?(String) || !v
          @value = v
        else
          self.image = v
          self.image.store!
          @value = image.file.filename
        end
      end

      def id
        name
      end

      def url
        image.url
      end

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
          super(content_class)

          content_class.class_exec(name) do |name|
            # define_method name do
            #   col_hash[name]
            # end
            # define_method "#{name}=" do |v|
            #   col_hash[name].image = v
            #   col_hash[name].image.store!
            # end
            define_method "remove_#{name}" do
              col_hash[name].send "remove_image"
            end
            define_method "remove_#{name}=" do |v|
              if v=="1"
                col_hash[name].send "remove_image!"
                col_hash[name].send "set_value", nil
              end
              col_hash[name].send "remove_image=", v
            end
            define_method "#{name}_cache" do
              col_hash[name].send "image_cache"
            end
          end
        end
      end

    end

    class Medium < Column
    end

    class Date < Column
      def set_value(v)
        @value = v.present? ? v.to_date : nil
      end

      def value_to_serialize
        @value.is_a?(Date) ? @valuet.strftime('%Y-%m-%d') : @value
      end
    end

    class Address < Column
      def pref_value
        value[:prefecture] || value['prefecture']
      end
      
      def address_value
        value[:address] || value['address']
      end

      def to_s
        if value.is_a?(Hash) && pref_value.present? #deprecated
          Gnoibox::Prefecture.option_hash[pref_value.to_sym].settings[:full_text] + address_value
        else
          value.to_s
        end
      end
      
      def axis_values
        [to_s]
      end
    end
    
    class Station < Column
      def value
        @value || {}
      end

      def set_value(v)
        return unless v
        @value = v.is_a?(Hash) ? v : {station_id: v, title: Gnoibox::Station.suggest_options.detect{|o| o[0]==v }.try(:last) }
      end

      def to_s
        value[:title] || value["title"] || ""
      end
      
      def station_id
        value[:station_id] || value["station_id"]
      end
      
      def axis_values
        Array(station_id)
      end
    end
  end
end

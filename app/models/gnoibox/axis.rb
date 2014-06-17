module Gnoibox
  class Axis
    # MATCH_TYPES = [:equal, :range, :month, :age, :prefecture, :city, :railway, :station, :custom]

    class << self
      attr_reader :key, :label

      def set_key(key, label)
        Gnoibox::AxisCollection.add self
        @key = key.to_sym
        @label = label
      end

      def set_label(v) @label=v end

      def set_type(type)
        @type = type
      end
      def type
        @type ||= :equal
      end

      def set_option(key, label, settings={})
        options << Option.new(key, label, settings)
      end

      def options
        @options ||= []
      end
      def option_keys
        options.map(&:key)
      end
      def option_hash
        @option_hash ||= options.index_by(&:key)
      end
      def option(key)
        option_hash[key.to_sym]
      end

      def tag_for(v)
        case type
        when :equal then option_keys.include?(v.to_sym) ? v : nil
        when :range then nil #match all
        when :month then nil #v is date
        when :age then nil #v is date
        when :prefecture then Gnoibox::Axis::Prefecture.find_all_tag(v)
        when :city then Gnoibox::Axis::City.find_all_tag(v)
        when :railway then Gnoibox::Axis::Railway.find_all_tag(v)
        when :station then Gnoibox::Axis::Station.find_all_tag(v)
        when :custom then find_all_tag(v)
        end
      end
      
      def find_all_tag(v)
        #to be overriden on custom axis type
      end
      
      def match_age(v)
        #v is date
      end
    end


    class Option
      attr_reader :key, :label, :settings
      def initialize(key, label, settings={})
        @key = key.to_sym
        @label = label
        @settings = settings
      end
    end
  end
end

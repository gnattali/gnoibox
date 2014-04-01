module Gnoibox
  class Axis
    MATCH_TYPES = [:equal, :range, :below, :above, :month, :prefecture, :city, :rail, :station]

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
        when :range then nil
        when :below then nil
        when :above then nil
        when :month then nil
        when :prefecture then nil
        when :city then nil
        when :rail then nil
        when :station then nil
        end
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

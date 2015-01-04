module Gnoibox
  class Axis
    # MATCH_TYPES = [:equal, :range, :group, :month, :age, :prefecture, :city, :railway, :station, :custom]

    class << self
      attr_reader :key, :label

      def set_key(key, label)
        Gnoibox::AxisCollection.add self
        @key = key.to_sym
        @label = label
      end

      def set_label(v) @label=v end

      def set_type(type)
        # deprecated
        # use include Gnoibox::Axis::Type::Hoge instead
      end
      def type
        :equal
      end

      def allow_in_axis_cross_search
        @allowed_to_cross_search_in_axis = true
      end
      
      def allowed_to_cross_search_in_axis
        @allowed_to_cross_search_in_axis || false
      end

      def set_option(key, label, settings={})
        options << Option.new(key, label, settings)
      end

      def options
        @options ||= []
      end
      def option_keys
        @option_keys ||= options.map(&:key)
      end
      def option_hash
        @option_hash ||= options.index_by(&:key)
      end
      def option(key)
        option_hash[key.to_sym]
      end
      
      def tag_for(v)
        option_keys.include?(v.to_sym) ? v : nil
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

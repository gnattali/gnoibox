module Gnoibox
  module ColumnSelectable
    extend ActiveSupport::Concern

    included do
      delegate :options, :select_options, :option_hash, to: :class
    end

    def to_s
      v = Array(value).first.try(:to_sym)
      value.present? ? option_hash[v] : ""
    end
    alias_method :text, :to_s

    module ClassMethods
      def options
        main_axis ? main_axis.options : settings[:options].map{|key, label| Axis::Option.new(key, label) }
      end

      def select_options
        options.map{|option| [option.label, option.key] }
      end

      def option_hash
        Hash[options.map{|option| [option.key, option.label] }]
      end
    end
  end
end

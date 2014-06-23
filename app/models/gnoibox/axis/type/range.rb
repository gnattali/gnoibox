module Gnoibox
  module Axis::Type
    module Range
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :range end

        def tag_for(v)
          return nil if v=="" || v==nil
          options.select{|o| o.settings[:range].include? v.to_f }.map(&:key)
        end
      end

    end
  end
end

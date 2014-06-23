module Gnoibox
  module Axis::Type
    module Age
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :age end

        def tag_for(v)
          return nil if v=="" || v==nil || !v.is_a?(Date)
          year = (Date.current - v).to_i / 365
          options.select{|o| o.settings[:range].include? year.to_f }.map(&:key)
        end
      end

    end
  end
end

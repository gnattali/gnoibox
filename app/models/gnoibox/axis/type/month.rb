module Gnoibox
  module Axis::Type
    module Month
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :month end

        def tag_for(v)
          
        end
      end

    end
  end
end

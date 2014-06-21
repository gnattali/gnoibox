module Gnoibox
  module Axis::Type
    module Range
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :range end

        def tag_for(v)
          
        end
      end

    end
  end
end

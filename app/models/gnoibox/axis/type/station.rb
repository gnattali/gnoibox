module Gnoibox
  module Axis::Type
    module Station
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :station end

        def tag_for(v)
          
        end
      end

    end
  end
end
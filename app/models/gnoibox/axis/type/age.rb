module Gnoibox
  module Axis::Type
    module Age
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :age end

        def tag_for(v)
          
        end
      end

    end
  end
end

module Gnoibox
  module Axis::Type
    module Railway
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :railway end

        def options
          Gnoibox::Railway.axis_options
        end
          
        def tag_for(v)
          
        end
      end

    end
  end
end

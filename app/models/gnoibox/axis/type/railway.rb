module Gnoibox
  module Axis::Type
    module Railway
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :railway end

        def options
          Gnoibox::Axis::Type::RailwayOptions.all
        end
          
        def tag_for(v)
          
        end
      end

    end
  end
end

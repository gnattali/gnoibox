module Gnoibox
  module Axis::Type
    module Station
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :station end

        def options
          Gnoibox::Station.axis_options
        end
        
        def option_keys
          Gnoibox::Station.option_keys
        end
        
        def option_hash
          Gnoibox::Station.option_hash
        end

        def tag_for(station_id)
          Gnoibox::Station.key_for(station_id)
        end
      end

    end
  end
end

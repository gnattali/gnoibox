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

        def option_keys
          Gnoibox::Railway.option_keys
        end
        
        def option_hash
          Gnoibox::Railway.option_hash
        end
        
        def tag_for(station_id)
          Gnoibox::Station.railway_key_for(station_id)
        end
      end

    end
  end
end

module Gnoibox
  module Axis::Type
    module Free
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :free end

        def set_delimiter(v)
          @delimiter = v
        end
        def delimiter
          @delimiter ||= ','
        end

        def tag_for(v)
          v.split(delimiter).reject(&:blank?)          
        end
      end

    end
  end
end

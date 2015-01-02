module Gnoibox
  module Axis::Type
    module Prefecture
      extend ActiveSupport::Concern

      included do
      
      end

      module ClassMethods
        def type() :prefecture end

        def options
          Gnoibox::Prefecture.axis_options
        end
        
        def full_text_hash
          Gnoibox::Prefecture.full_text_hash
        end
        
        def full_text_list
          full_text_hash.keys
        end
        
        def tag_for(v)
          full_text_list.detect do |t|
            break full_text_hash[t].key if v.index(t)==0
          end
        end

      end

    end
  end
end

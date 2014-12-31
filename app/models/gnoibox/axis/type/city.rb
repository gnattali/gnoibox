module Gnoibox
  module Axis::Type
    module City
      extend ActiveSupport::Concern

      included do
        
      end

      module ClassMethods
        def type() :city end

        def options
          Gnoibox::Axis::Type::CityOptions.all
        end

        def text_hash
          Gnoibox::Axis::Type::CityOptions.text_hash
        end

        def text_list
          text_hash.keys
        end
        
        def tag_for(v)
          if pref_key = Gnoibox::Axis::Prefecture.tag_for(v)
            pref_text = Gnoibox::Axis::Prefecture.option_hash[pref_key].settings[:full_text]
            v = v.sub /^#{pref_text}/, ''
          end
          text_list.detect do |t|
            break text_hash[t].key if v.index(t)==0
          end
        end

      end

    end
  end
end

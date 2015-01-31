module Gnoibox
  module Axis::Type
    module City
      extend ActiveSupport::Concern

      included do
        
      end

      module ClassMethods
        def type() :city end

        def options
          Gnoibox::City.axis_options
        end

        def option_keys
          Gnoibox::City.option_keys
        end
        
        def option_hash
          Gnoibox::City.option_hash
        end
        
        def text_hash
          Gnoibox::City.text_hash
        end

        def text_hash_with_pref
          Gnoibox::City.text_hash_with_pref
        end
        
        def text_list
          Gnoibox::City.text_list
        end
        
        def text_list_with_pref
          Gnoibox::City.text_list_with_pref
        end
        
        def tag_for(v)
          if (pref_keys = Gnoibox::Axis::Prefecture.tag_for(v)).present?
            # pref_text = pref_keys.map{|pref_key| Gnoibox::Axis::Prefecture.option_hash[pref_key].settings[:full_text] }.join("|")
            # v = v.gsub /#{pref_text}/, ''
            text_list_with_pref.map{|t| text_hash_with_pref[t].key if v.include?(t) }.compact
          else
            text_list.map{|t| text_hash[t].key if v.include?(t) }.compact
          end
        end

      end

    end
  end
end

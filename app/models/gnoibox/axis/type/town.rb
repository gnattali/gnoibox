module Gnoibox
  module Axis::Type
    module Town
      extend ActiveSupport::Concern

      included do
        
      end

      module ClassMethods
        def type() :town end

        def options
          Gnoibox::Town.axis_options
        end

        def option_keys
          Gnoibox::Town.option_keys
        end
        
        def option_hash
          Gnoibox::Town.option_hash
        end
        
        def text_hash
          Gnoibox::Town.text_hash
        end

        def text_list
          Gnoibox::Town.text_list
        end
        
        def tag_for(v)
          # if /^[0-9０-９ー\s-]+$/.match v
          #   v.gsub!(/[０-９\s　ー-]/, Hash[("０".."９").zip(0..9)] )
          #   #detect from zipcode
          # end
          
          if (pref_keys = Gnoibox::Axis::Prefecture.tag_for(v)).present?
            pref_text = pref_keys.map{|pref_key| Gnoibox::Axis::Prefecture.option_hash[pref_key].settings[:full_text] }.join("|")
            v = v.gsub /#{pref_text}/, ''
          end
          text_list.map{|t| text_hash[t].key if v.include?(t) }.compact
        end

      end

    end
  end
end

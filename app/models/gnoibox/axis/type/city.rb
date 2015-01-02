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

        def text_hash
          Gnoibox::City.text_hash
        end

        def text_list
          Gnoibox::City.text_list
        end
        
        def tag_for(v)
          if (pref_keys = Gnoibox::Axis::Prefecture.tag_for(v)).present?
            pref_text = pref_keys.map{|pref_key| Gnoibox::Axis::Prefecture.option_hash[pref_key].settings[:full_text] }.join("|")
            v.gsub! /#{pref_text}/, ''
          end
          text_list.map{|t| text_hash[t].key if v.include?(t) }.compact
        end

      end

    end
  end
end

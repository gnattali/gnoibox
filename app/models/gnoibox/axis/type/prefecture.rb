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

        def option_keys
          Gnoibox::Prefecture.option_keys
        end
        
        def option_hash
          Gnoibox::Prefecture.option_hash
        end
        
        def full_text_hash
          Gnoibox::Prefecture.full_text_hash
        end

        def full_text_list
          Gnoibox::Prefecture.full_text_list
        end
        
        def tag_for(v)
          # if /^[0-9０-９ー\s-]+$/.match v
          #   v.gsub!(/[０-９\s　ー-]/, Hash[("０".."９").zip(0..9)] )
          #   #detect from zipcode
          # end

          full_text_list.map{|t| full_text_hash[t].key if v.include?(t) }.compact
        end

      end

    end
  end
end

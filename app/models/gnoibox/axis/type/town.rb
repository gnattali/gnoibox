module Gnoibox
  module Axis::Type
    module Town
      extend ActiveSupport::Concern

      included do
        
      end

      module ClassMethods
        def type() :town end

        # def options
        #   Gnoibox::Town.axis_options
        # end
        # 
        # def option_keys
        #   Gnoibox::Town.option_keys
        # end
        # 
        # def option_hash
        #   Gnoibox::Town.option_hash
        # end
        # 
        # def text_hash_with_city
        #   Gnoibox::Town.text_hash_with_city
        # end

        def text_list_with_city
          Gnoibox::Town.text_list_with_city
        end
        
        def tag_for(v)
          # if /^[0-9０-９ー\s-]+$/.match v
          #   z = v.gsub(/[０-９\s　ー-]/, Hash[("０".."９").zip(0..9)] )
          #   #detect from zipcode
          # end
          
          # text_list_with_city.map{|t| text_hash_with_city[t].key if v.include?(t) }.compact

          text_list_with_city.select{|t| v.include?(t) }
        end

      end

    end
  end
end

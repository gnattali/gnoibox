module Gnoibox
  module Axis::Type
    module City
      extend ActiveSupport::Concern

      included do

        CSV.foreach(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.csv")) do |r|
          set_option "city_#{r[3]}", r[2], {prefecture_id: r[0], city_id: r[1]}
        end

      end

      module ClassMethods
        def type() :city end

        # def prefecture_hash
        #   @prefecture_hash ||= options.group_by(&:)
        # end
        
        # def tag_for(v)
        #   if pref_key = Gnoibox::Axis::Prefecture.tag_for(v)
        #     prefecture_id = Gnoibox::Axis::Prefecture.options[pref_key].settings[:prefecture_id]
        #     
        #   end
        #   
        # end

      end

    end
  end
end

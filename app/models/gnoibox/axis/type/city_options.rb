module Gnoibox
  module Axis::Type
    class CityOptions

      def self.all
        @all ||= begin
          Gnoibox::City.arrays.map do |r|
            Gnoibox::Axis::Option.new "city_#{r[3]}", r[2], {prefecture_id: r[0], city_id: r[1]}
          end
        end
      end

      def self.text_hash
        @text_hash ||= all.index_by(&:label)
      end
      
    end
  end
end

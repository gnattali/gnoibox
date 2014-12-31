module Gnoibox
  module Axis::Type
    class StationOptions

      def self.all
        @all ||= begin
          Gnoibox::Station.arrays.map do |r|
            Gnoibox::Axis::Option.new "station_#{r[4]}", r[1], {railway_id: r[3]}
          end
        end
      end

    end
  end
end

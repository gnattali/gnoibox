module Gnoibox
  module Axis::Type
    class RailwayOptions

      def self.all
        @all ||= begin
          Gnoibox::Railway.arrays.map do |r|
            Gnoibox::Axis::Option.new "railway_#{r[2]}", r[1], {line_type: r[3], railway_id: r[0]}
          end
        end
      end

    end
  end
end

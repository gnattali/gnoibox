require 'csv'

module Gnoibox
  class Station

    def self.arrays
      #id,title,prefecture_id,railway_id,station_key,title_unique,title_kana,latitude,longitude,station_g_cd,position
      @arrays ||= CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "stations.csv"))
    end

    def self.axis_options
      @axis_options ||= begin
        arrays.map do |r|
          Gnoibox::Axis::Option.new "#{r[4]}_station", r[1], {railway_id: r[3]}
        end
      end
    end

  end
end

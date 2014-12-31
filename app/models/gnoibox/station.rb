require 'csv'

module Gnoibox
  class Station
    def self.arrays
      #id,title,prefecture_id,railway_id,station_key,title_unique,title_kana,latitude,longitude,station_g_cd,position
      @arrays ||= CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "stations.csv"))
    end
  end
end

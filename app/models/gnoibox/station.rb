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

    def self.option_keys
      @option_keys ||= axis_options.map(&:key)
    end

    def self.option_hash
      @option_hash ||= axis_options.index_by(&:key)
    end
    
    def self.suggest_options
      @suggest_options ||= begin
        dic = Gnoibox::Railway.long_title_dictionary
        arrays.map{|s| [ s[0], dic[s[3]]+" "+s[1]+"駅" ] if dic[s[3]] }.compact
      end
    end

    def self.select2_options_for(q)
      suggest_options.lazy.select{|o| o[1].include? q }.first(100).map{|o| {id: o[0], text: o[1]} }
    end
  end
end

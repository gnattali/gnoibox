module Gnoibox
  class Station
    def self.csv_arrays
      require 'csv'
      #id,title,prefecture_id,railway_id,station_key,title_unique,title_kana,latitude,longitude,station_g_cd,position
      CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "stations.csv"))
    end

    def self.dump_arrays
      File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "stations.dump"), 'w') do |f|
        Marshal.dump csv_arrays.map{|r| [r[0],r[1],r[2],r[4]] }, f
      end
    end
    
    def self.arrays
      #id,title,prefecture_id,station_key
      Rails.cache.fetch("gnoibox/station/arrays")fetch{ File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "stations.dump"), 'r'){|f| Marshal.load(f) } }
      # @arrays ||= File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "stations.dump"), 'r'){|f| Marshal.load(f) }
    end

    def self.gnoibox_key_from(key)
      return nil unless key
      (key + "_station").to_sym
    end

    def self.railway_id_from(station_id)
      station_id[0,5]
    end

    def self.axis_options
      Rails.cache.fetch("gnoibox/station/axis_options"){ arrays.map{|r| Gnoibox::Station::Option.new gnoibox_key_from(r[3]), r[1], r[0] } }
      # @axis_options ||= arrays.map{|r| Gnoibox::Station::Option.new gnoibox_key_from(r[3]), r[1], r[0] }
    end

    def self.option_keys
      Rails.cache.fetch("gnoibox/station/options_keys"){ axis_options.map(&:key) }
      # @option_keys ||= axis_options.map(&:key)
    end

    def self.option_hash
      #reverse to reflect priority
      Rails.cache.fetch("gnoibox/station/option_hash"){ axis_options.reverse.index_by(&:key) }
      # @option_hash ||= axis_options.reverse.index_by(&:key)
    end
    
    def self.id_hash
      Rails.cache.fetch("gnoibox/station/id_hash"){ axis_options.index_by{|o| o.station_id.to_sym} }
      # @id_hash ||= axis_options.index_by{|o| o.station_id.to_sym}
    end
    
    def self.title_for(id)
      id_hash[id.to_sym].try(:label)
    end

    def self.key_for(id)
      id_hash[id.to_sym].try(:key)
    end

    def self.railway_key_for(id)
      return nil unless option = id_hash[id.to_sym]
      Gnoibox::Railway.key_for railway_id_from(option.station_id)
    end
    
    def self.suggest_options
      Rails.cache.fetch("gnoibox/station/suggest_options") do
        dic = Gnoibox::Railway.long_title_dictionary
        arrays.map do |s|
          if railway = dic[railway_id_from(s[0])]
            [ s[0], railway+" "+s[1]+"駅" ]
          end
        end.compact
      end
      # @suggest_options ||= begin
      #   dic = Gnoibox::Railway.long_title_dictionary
      #   arrays.map do |s|
      #     if railway = dic[railway_id_from(s[0])]
      #       [ s[0], railway+" "+s[1]+"駅" ]
      #     end
      #   end.compact
      # end
    end

    def self.select2_options_for(q)
      suggest_options.lazy.select{|o| o[1].include? q }.first(100).map{|o| {id: o[0], text: o[1]} }
    end
    
    def self.railway_hash
      Rails.cache.fetch("gnoibox/station/railway_hash") do
        arrays.map{|s| [railway_id_from(s[0]), gnoibox_key_from(s[3])] }.group_by{|s| s[0] }.to_a.map{|r| [Gnoibox::Railway.key_for(r[0]), r[1].map{|s| s[1]} ] }.to_h
      end
      # @railway_hash ||= begin
      #   arrays.map{|s| [railway_id_from(s[0]), gnoibox_key_from(s[3])] }.group_by{|s| s[0] }.to_a.map{|r| [Gnoibox::Railway.key_for(r[0]), r[1].map{|s| s[1]} ] }.to_h
      # end
    end

    class Option
      attr_reader :key, :label, :station_id
      def initialize(key, label, station_id)
        @key = key
        @label = label
        @station_id = station_id
      end
    end
    
  end
end

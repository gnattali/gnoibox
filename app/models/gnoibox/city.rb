module Gnoibox
  class City
    def self.csv_arrays
      require 'csv'
      #prefecture_id,city_id,title,city_key
      CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.csv"))
    end

    def self.dump_arrays
      File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.dump"), 'w') do |f|
        Marshal.dump csv_arrays, f
      end
    end
    
    def self.arrays
      Rails.cache.fetch("gnoibox/city/arrays"){ File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.dump"), 'r'){|f| Marshal.load(f) } }
      # @arrays ||= File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.dump"), 'r'){|f| Marshal.load(f) }
    end
    
    def self.axis_options
      Rails.cache.fetch("gnoibox/city/axis_options") do
        arrays.map do |r|
          Gnoibox::Axis::Option.new r[3], r[2], {prefecture_id: r[0], city_id: r[1]}
        end
      end
      # @axis_options ||= begin
      #   arrays.map do |r|
      #     Gnoibox::Axis::Option.new r[3], r[2], {prefecture_id: r[0], city_id: r[1]}
      #   end
      # end
    end

    def self.option_keys
      Rails.cache.fetch("gnoibox/city/option_keys"){ axis_options.map(&:key) }
      # @option_keys ||= axis_options.map(&:key)
    end
    
    def self.option_hash
      Rails.cache.fetch("gnoibox/city/options_hash"){ axis_options.index_by(&:key) }
      # @option_hash ||= axis_options.index_by(&:key)
    end
    
    def self.text_hash
      Rails.cache.fetch("gnoibox/city/text_hash"){ axis_options.index_by(&:label) }
      # @text_hash ||= axis_options.index_by(&:label)
    end
    
    def self.text_list
      Rails.cache.fetch("gnoibox/city/text_list"){ text_hash.keys }
      # @text_list ||= text_hash.keys
    end
    
  end
end

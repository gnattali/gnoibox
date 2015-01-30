module Gnoibox
  class Town
    def self.csv_arrays
      require 'csv'
      #jis_code,zip_code,city,town,town_key
      CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "zipcodes.csv"))
    end

    def self.dump_arrays
      File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "zipcodes.dump"), 'w') do |f|
        Marshal.dump csv_arrays, f
      end
    end
    
    def self.arrays
      Rails.cache.fetch("gnoibox/town/arrays"){ File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "zipcodes.dump"), 'r'){|f| Marshal.load(f) } }
    end
    
    def self.axis_options
      Rails.cache.fetch("gnoibox/town/axis_options") do
        arrays.map do |r|
          Gnoibox::Axis::Option.new r[3], r[2], {prefecture_id: r[0], city_id: r[1]}
        end
      end
    end

    def self.option_keys
      Rails.cache.fetch("gnoibox/town/option_keys"){ axis_options.map(&:key) }
    end
    
    def self.option_hash
      Rails.cache.fetch("gnoibox/town/options_hash"){ axis_options.index_by(&:key) }
    end
    
    def self.text_hash
      Rails.cache.fetch("gnoibox/town/text_hash"){ axis_options.index_by(&:label) }
    end
    
    def self.text_list
      Rails.cache.fetch("gnoibox/town/text_list"){ text_hash.keys }
    end
    
  end
end

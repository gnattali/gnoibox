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
      @arrays ||= File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.dump"), 'r'){|f| Marshal.load(f) }
    end
    
    def self.axis_options
      @axis_options ||= begin
        arrays.map do |r|
          Gnoibox::Axis::Option.new r[3], r[2], {prefecture_id: r[0], city_id: r[1]}
        end
      end
    end

    def self.option_keys
      @option_keys ||= axis_options.map(&:key)
    end
    
    def self.option_hash
      @option_hash ||= axis_options.index_by(&:key)
    end
    
    def self.text_hash
      @text_hash ||= axis_options.index_by(&:label)
    end
    
    def self.text_list
      @text_list ||= text_hash.keys
    end
    
  end
end

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
      # Rails.cache.fetch("gnoibox/city/arrays"){ File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.dump"), 'r'){|f| Marshal.load(f) } }
      @arrays ||= File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.dump"), 'r'){|f| Marshal.load(f) }
    end
    
    def self.axis_options
      # Rails.cache.fetch("gnoibox/city/axis_options") do
      #   arrays.map do |r|
      #     Gnoibox::City::Option.new r[3], r[2], r[0], r[1]
      #   end
      # end
      @axis_options ||= begin
        arrays.map do |r|
          Gnoibox::City::Option.new r[3], r[2], r[0], r[1]
        end
      end
    end

    def self.option_keys
      # Rails.cache.fetch("gnoibox/city/option_keys"){ axis_options.map(&:key) }
      @option_keys ||= axis_options.map(&:key)
    end
    
    def self.option_hash
      # Rails.cache.fetch("gnoibox/city/options_hash"){ axis_options.index_by(&:key) }
      @option_hash ||= axis_options.index_by(&:key)
    end
    
    def self.text_hash
      # Rails.cache.fetch("gnoibox/city/text_hash"){ axis_options.index_by(&:label) }
      @text_hash ||= axis_options.index_by(&:label)
    end
    
    def self.text_hash_with_pref
      # Rails.cache.fetch("gnoibox/city/text_hash_with_pref"){ axis_options.index_by{|o| Gnoibox::Prefecture::SEED[o.prefecture_id][1] + o.label } }
      @text_hash_with_pref ||= axis_options.index_by{|o| Gnoibox::Prefecture::SEED[o.prefecture_id][1] + o.label }
    end
    
    def self.text_list
      # Rails.cache.fetch("gnoibox/city/text_list"){ text_hash.keys }
      @text_list ||= text_hash.keys
    end

    def self.text_list_with_pref
      # Rails.cache.fetch("gnoibox/city/text_list_with_pref"){ text_hash_with_pref.keys }
      @text_list_with_pref ||= text_hash_with_pref.keys
    end

    def self.id_key_hash
      # Rails.cache.fetch("gnoibox/city/id_key_hash"){ arrays.map{|r| [r[1].to_sym,r[3]] }.to_h }
      @id_key_hash ||= arrays.map{|r| [r[1].to_sym,r[3]] }.to_h
    end

    class Option
      attr_reader :key, :label, :prefecture_id, :city_id
      def initialize(key, label, prefecture_id, city_id)
        @key = key.to_sym
        @label = label
        @prefecture_id = prefecture_id.to_s.rjust(2,"0")
        @city_id = city_id
      end
    end
    
  end
end

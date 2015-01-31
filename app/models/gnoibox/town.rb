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
      @arrays ||= File.open(File.join(Gnoibox::Engine.root, "db", "seeds", "zipcodes.dump"), 'r'){|f| Marshal.load(f) }
    end

    def self.gnoibox_key_from(key, city_id)
      return nil unless key
      if city_key = Gnoibox::City.id_key_hash[city_id.to_sym]
        "#{city_key}_#{cleanup_town_key(key)}".to_sym
      end
    end

    def self.cleanup_town_key(key)
      key.gsub("tsuginobiruwonozoku", "").gsub(/[\(\)]/, "").gsub("-","_")
    end
    
    def self.cleanup_town_name(name)
      name.delete "（次のビルを除く）"
    end
    
    # def self.axis_options
    #   # Rails.cache.fetch("gnoibox/town/axis_options") do
    #   #   arrays.map do |r|
    #   #     if key = gnoibox_key_from(r[4], r[0])
    #   #       Gnoibox::Town::Option.new key, cleanup_town_name(r[3]), r[2], r[1]
    #   #     end
    #   #   end.compact
    #   # end
    #   @axis_options ||= begin
    #     arrays.map do |r|
    #       if key = gnoibox_key_from(r[4], r[0])
    #         Gnoibox::Town::Option.new key, cleanup_town_name(r[3]), r[2], r[1]
    #       end
    #     end.compact
    #   end
    # end
    # 
    # def self.option_keys
    #   # Rails.cache.fetch("gnoibox/town/option_keys"){ axis_options.map(&:key) }
    #   @option_keys ||= axis_options.map(&:key)
    # end
    # 
    # def self.option_hash
    #   # Rails.cache.fetch("gnoibox/town/options_hash"){ axis_options.index_by(&:key) }
    #   @option_hash ||= axis_options.index_by(&:key)
    # end
    # 
    # def self.text_hash_with_city
    #   # Rails.cache.fetch("gnoibox/town/text_hash_with_city"){ axis_options.index_by{|o| o.city_name + o.label } }
    #   @text_hash_with_city ||= axis_options.index_by{|o| o.city_name + o.label }
    # end
    
    def self.text_list_with_city
      # @text_list_with_city ||= text_hash_with_city.keys
      @text_list_with_city ||= arrays.map{|t| t[2] + cleanup_town_name(t[3])}
    end
    
    class Option
      attr_reader :key, :label, :city_name, :zipcode
      def initialize(key, label, city_name, zipcode)
        @key = key.to_sym
        @label = label
        @city_name = city_name
        @zipcode = zipcode
      end
    end

  end
end

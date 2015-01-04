require 'csv'

module Gnoibox
  class Railway
    def self.arrays
      #id,title,railway_key,line_type,long_title,title_kana,line_g_cd
      @arrays ||= CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "railways.csv"))
    end
    
    def self.axis_options
      @axis_options ||= begin
        arrays.map do |r|
          Gnoibox::Axis::Option.new r[2], r[1], {line_type: r[3], railway_id: r[0]}
        end
      end
    end
    
    def self.option_keys
      @option_keys ||= axis_options.map(&:key)
    end
    
    def self.option_hash
      @option_hash ||= axis_options.index_by(&:key)
    end

    def self.id_hash
      @id_hash ||= axis_options.index_by{|o| o.settings[:railway_id].to_s}
    end

    def self.key_for(id)
      id_hash[id.to_s].try(:key)
    end

    def self.long_title_dictionary
      @long_title_dictionary ||= Hash[ arrays.map{|r| [r[0],r[4]] } ]
    end

  end
end

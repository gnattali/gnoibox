require 'csv'

module Gnoibox
  class City
    def self.arrays
      #prefecture_id,city_id,title,city_key
      @arrays ||= CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.csv"))
    end

    def self.axis_options
      @axis_options ||= begin
        arrays.map do |r|
          Gnoibox::Axis::Option.new "city_#{r[3]}", r[2], {prefecture_id: r[0], city_id: r[1]}
        end
      end
    end
    
    def self.text_hash
      @text_hash ||= axis_options.index_by(&:label)
    end
    
  end
end
require 'csv'

module Gnoibox
  class Railway

    def self.arrays
      #id,title,railway_key,line_type,title_long,title_kana,line_g_cd
      @arrays ||= CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "railways.csv"))
    end
    
    def self.axis_options
      @axis_options ||= begin
        arrays.map do |r|
          Gnoibox::Axis::Option.new "#{r[2]}_railway", r[1], {line_type: r[3], railway_id: r[0]}
        end
      end
    end

  end
end

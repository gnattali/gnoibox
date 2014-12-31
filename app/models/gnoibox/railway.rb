require 'csv'

module Gnoibox
  class Railway
    def self.arrays
      #id,title,railway_key,line_type,title_long,title_kana,line_g_cd
      @arrays ||= CSV.read(File.join(Gnoibox::Engine.root, "db", "seeds", "railways.csv"))
    end
  end
end

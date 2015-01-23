module Gnoibox
  class AxisCollection
    include CollectionHoldable
    def self.collection_type
      'axis'
    end

    def self.option_keys
      # Rails.cache.fetch("gnoibox/axis_collection/option_keys"){ all.map(&:option_keys).flatten }
      @option_keys ||= all.map(&:option_keys).flatten
    end      

  private
    
    def self.load_files
      Gnoibox::BoxCollection.all#to preload axes in use from gnoibox presets
      super
    end
    
  end
end

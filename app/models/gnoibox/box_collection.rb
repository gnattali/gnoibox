module Gnoibox
  class BoxCollection
    include CollectionHoldable
    def self.collection_type
      'box'
    end
    
    def self.reset_order_values
      all.each(&:reset_order_values)
    end

    def self.all
      super.sort_by(&:position)
    end

  private

    def self.load_files
      super
      Gnoibox::Box::Root
      Gnoibox::Box::Facet
    end

  end
end

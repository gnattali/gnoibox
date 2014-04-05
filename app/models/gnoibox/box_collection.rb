module Gnoibox
  class BoxCollection
    include CollectionHoldable
    def self.collection_type
      'box'
    end
    
    def self.reset_order_values
      all.each(&:reset_order_values)
    end

  end
end

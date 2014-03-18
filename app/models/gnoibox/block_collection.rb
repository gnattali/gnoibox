module Gnoibox
  class BlockCollection
    include CollectionHoldable
    def self.collection_type
      'block'
    end

    def self.load_substance(key)
      find(key).substance
    end

    def self.load(key)
      find(key).content
    end

  end
end
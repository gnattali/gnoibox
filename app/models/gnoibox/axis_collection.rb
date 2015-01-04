module Gnoibox
  class AxisCollection
    include CollectionHoldable
    def self.collection_type
      'axis'
    end

    class << self
      def option_keys
        @option_keys ||= all.map(&:option_keys).flatten
      end      
    end

  end
end

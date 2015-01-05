module Gnoibox
  class Block < ActiveRecord::Base
    include ColumnHoldable

    self.table_name= :gnoibox_blocks

    validates :key, presence: true, uniqueness: true

    def to_param() self.class.key end

    def label() self.class.label end

    class << self
      attr_reader :key, :label
      def set_key(key, label)
        Gnoibox::BlockCollection.add self
        @key = key.to_sym
        @label = label
      end

      def to_param()
        key
      end

      def substance
        find_or_create_by(key: key)
      end

      def content
        substance.content
      end

    end
  end
end

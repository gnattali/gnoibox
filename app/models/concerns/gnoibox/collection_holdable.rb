module Gnoibox
  module CollectionHoldable
    extend ActiveSupport::Concern

    included do

    end

    module ClassMethods
      def collection_type
        nil #override in parent. ex 'box'
      end

      def add(v)
        collection << v
      end

      def all
        @all ||= begin
          load_files
          collection
        end
      end

      def keys
        @keys ||= all.map(&:key)
      end

      def hash
        @hash ||= all.index_by(&:key)
      end

      def find(key)
        hash[key.to_sym]
      end

    private

      def collection
        @collection ||= []
      end

      def load_files
        raise 'please override collection_type' unless collection_type
        @loaded_files ||= Dir.glob(File.join(Rails.application.config.root, "app", "models", "gnoibox", collection_type, "*.rb")).each do |file|
          require_dependency file
        end
      end

    end
  end
end
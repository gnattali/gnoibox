module Gnoibox
  class FormCollection
    include CollectionHoldable
    def self.collection_type
      'form'
    end
    
  private

    def self.load_files
      super
      Gnoibox::Form::Root
    end

  end
end

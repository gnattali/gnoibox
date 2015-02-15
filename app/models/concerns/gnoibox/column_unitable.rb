module Gnoibox
  module ColumnUnitable
    extend ActiveSupport::Concern

    included do
    end

    def unit
      settings[:unit]
    end
    
    def text_with_unit
      text.to_s + unit.to_s
    end

    module ClassMethods
    end
  end
end

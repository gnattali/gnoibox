module Gnoibox
  module Axis::Type
    module Group
      extend ActiveSupport::Concern

      included do

      end

      module ClassMethods
        def type() :group end

        def tag_for(v)
          return nil if v=="" || v==nil
          options.select{|o| o.settings[:group].map(&:to_s).include? v.to_s }.map(&:key)
        end
      end

    end
  end
end

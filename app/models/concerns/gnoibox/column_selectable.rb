module Gnoibox
  module ColumnSelectable
    extend ActiveSupport::Concern

    included do

    end

    def settings
      self.class.settings
    end

    def options
      settings[:axis] ? settings[:axis].options : settings[:options].map{|key, label| Axis::Option.new(key, label) }
    end

    def select_options
      options.map{|option| [option.label, option.key] }
    end

    def option_hash
      Hash[options.map{|option| [option.key, option.label] }]
    end

    def text
      value.present? ? option_hash[value.to_sym] : ""
    end


    module ClassMethods

    end
  end
end

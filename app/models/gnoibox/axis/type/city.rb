require 'csv'

module Gnoibox
  module Axis::Type
    module City
      extend ActiveSupport::Concern

      included do

        CSV.foreach(File.join(Gnoibox::Engine.root, "db", "seeds", "cities.csv")) do |r|
          set_option "city_#{r[3]}", r[2], {prefecture_id: r[0], city_id: r[1]}
        end

      end

      module ClassMethods
        def type() :city end

        def text_hash
          @text_hash ||= options.index_by(&:label)
        end

        def text_list
          text_hash.keys
        end
        
        def tag_for(v)
          if pref_key = Gnoibox::Axis::Prefecture.tag_for(v)
            pref_text = Gnoibox::Axis::Prefecture.option_hash[pref_key].settings[:full_text]
            v.sub! /^#{pref_text}/, ''
          end
          text_list.detect do |t|
            break text_hash[t].key if v.index(t)==0
          end
        end

      end

    end
  end
end

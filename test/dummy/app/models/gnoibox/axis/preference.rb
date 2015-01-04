module Gnoibox
  class Axis::Preference < Axis
    set_key :preference, 'こだわり条件'

    set_option :pet_ok, 'ペット可'
    set_option :designers, 'デザイナーズ'
    set_option :floor_heating, '床暖房'

    allow_in_axis_cross_search
  end
end

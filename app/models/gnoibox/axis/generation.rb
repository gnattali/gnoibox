module Gnoibox
  class Axis::Generation < Axis
    include Gnoibox::Axis::Type::Age

    set_key :generation, '世代'

    set_option :below_10_years_old, '10歳未満', range: (0..9)
    set_option :teenager '10代', range: (10..19)
    set_option :twenties '20代', range: (20..29)
    set_option :thirties '30代', range: (30..39)
    set_option :forties '40代', range: (40..49)
    set_option :fifties '50代', range: (50..59)
    set_option :sixties '60代', range: (60..69)
    set_option :seventies '70代', range: (70..79)
    set_option :eighties '80代', range: (80..89)
    set_option :nineties '90代', range: (90..99)
    set_option :over_hundred '100歳以上', range: (100..9999)
  end
end

module Gnoibox
  class Axis::FloorSpace < Axis
    include Gnoibox::Axis::Type::Range
    
    set_key :floor_space, '建物面積'
    
    set_option :in40, '40㎡未満', range: (0..40)
    set_option :from40_to50, '40〜50㎡', range: (40..50)
    set_option :from50_to55, '50〜55㎡', range: (50..55)
    set_option :from55_to60, '55〜60㎡', range: (55..60)
    set_option :from60_to65, '60〜65㎡', range: (60..65)
    set_option :from65_to70, '65〜70㎡', range: (65..70)
    set_option :from70_to80, '70〜80㎡', range: (70..80)
    set_option :from80_to90, '80〜90㎡', range: (80..90)
    set_option :from90_to100, '90〜100㎡', range: (90..100)
    set_option :from100, '100㎡以上', range: (100..999999999999)
  end
end

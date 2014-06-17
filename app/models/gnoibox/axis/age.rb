module Gnoibox
  class Axis::Age < Axis
    set_key :age, '経過年数'
    set_type :age

    set_option :in_3year, '3年以内', condition: (0..3)
    set_option :in_5year '5年以内', condition: (0..5)
    set_option :in_10year, '10年以内', condition: (0..10)
  end
end

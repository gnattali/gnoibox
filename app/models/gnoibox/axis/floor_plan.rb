module Gnoibox
  class Axis::FloorPlan < Axis
    include Gnoibox::Axis::Type::Group

    set_key :floor_plan, '間取り'

    set_option :one_room, 'ワンルーム', group: ['ワンルーム']
    set_option :"1ldk", '1K〜1LDK', group: ['1K','1DK','1LDK']
    set_option :"2ldk", '2K〜2LDK', group: ['2K','2DK','2LDK']
    set_option :"3ldk", '3K〜3LDK', group: ['3K','3DK','3LDK']
    set_option :"4ldk", '4K〜4LDK', group: ['4K','4DK','4LDK']
    set_option :"5ldk", '5K以上', group: ['5k','5dk','5ldk','6k','6dk','6ldk','7k','7dk','7ldk','8k','8dk','8ldk','9k','9dk','9ldk']
  end
end

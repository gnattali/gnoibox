module Gnoibox
  class Block::BaseInfo < Block
    set_key :base_info, '基本情報'

    set_col :email, :text, 'メールアドレス'
    set_col :tel, :text, '電話番号'
  end
end

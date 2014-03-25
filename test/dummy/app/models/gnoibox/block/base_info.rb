module Gnoibox
  class Block::BaseInfo < Block
    set_key :base_info, '基本情報'

    col :email, :text, 'メールアドレス'
    col :tel, :text, '電話番号'
  end
end

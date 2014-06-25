module Gnoibox
  class Block::BaseInfo < Block
    set_key :base_info, '基本情報'

    set_col :site_name, :text, 'サイト名'
    set_col :og_image_url, :text, 'og image url'
    set_col :og_image_upload, :image, 'og imageアップロード'
    set_col :main_keywords, :text, 'メインキーワード'

    set_col :email, :text, '問い合わせ先メールアドレス'
    set_col :tel, :text, '問い合わせ先電話番号'
    
  end
end

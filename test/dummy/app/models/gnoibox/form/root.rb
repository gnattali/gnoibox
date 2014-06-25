module Gnoibox
  class Form::Root < Form
    set_key :root, 'お問い合わせ'
  end

  class Inquiry::Root < Inquiry
    set_col :name, :text, 'お名前', validates: {presence: true}
    set_col :email, :text, 'メールアドレス', validates: { presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ } }

    set_col :select_col, :select, 'selectサンプル', options: {a: 'A', b: 'B', c: 'C'}
    set_col :radio_col, :radio, 'radioサンプル', options: {a: 'A', b: 'B', c: 'C'}
    set_col :check_box_col, :check_box, 'check_boxサンプル', options: {a: 'A', b: 'B', c: 'C'}

    set_col :description, :text_area, 'お問い合わせ内容'
  end
end

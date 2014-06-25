module Gnoibox
  class Form::Root < Form
    set_key :root, 'お問い合わせ'
  end

  class Inquiry::Root < Inquiry
    set_col :name, :text, 'お名前', validates: {presence: true}
    set_col :email, :text, 'メールアドレス', validates: { presence: true, format: { with: EMAIL_VALIDATION } }
    set_col :description, :text_area, 'お問い合わせ内容'
  end
end

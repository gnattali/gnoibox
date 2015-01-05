module Gnoibox
  class Form::Root < Form
    set_key :root, 'お問い合わせ'

    set_list_cols [:name, :email]

    set_view_file 'gnoibox/forms/new'
    set_thanks_view 'gnoibox/forms/thanks'
  end

  class Inquiry::Root < Inquiry
    set_col :name, :text, 'お名前', validates: {presence: true}
    set_col :email, :email, 'メールアドレス', belongs_to_inquirer: true, validates: { presence: true, format: { with: EMAIL_VALIDATION } }
    set_col :description, :text_area, 'お問い合わせ内容'
  end
end

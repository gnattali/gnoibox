module Gnoibox
  class Form::Building < Form
    set_key :building, '物件お問い合わせ'

    set_list_cols [:name, :email]
    
    set_view_file 'gnoibox/forms/new'
    set_thanks_view 'gnoibox/forms/thanks'

    set_notice_mail_view "building_notice"
    set_thanks_mail_view "building_thanks"

    def self.notice_mail_subject(url_parser)
      "【#{url_parser.item.title}】お問合せがありました"
    end

    def self.thanks_mail_subject(url_parser)
      "【#{url_parser.item.title}】お問合せありがとうございます"
    end
  end

  class Inquiry::Building < Inquiry
    set_col :name, :text, 'お名前', validates: {presence: true}
    set_col :email, :email, 'メールアドレス', validates: { presence: true, format: { with: EMAIL_VALIDATION } }

    set_col :auto_reply_email, :email, '返信先メール', belongs_to_inquirer: true
    
    set_col :select_col, :select, 'selectサンプル', options: {a: 'A', b: 'B', c: 'C'}, include_blank: true
    set_col :radio_col, :radio, 'radioサンプル', options: {a: 'A', b: 'B', c: 'C'}
    set_col :check_box_col, :check_box, 'check_boxサンプル', options: {a: 'A', b: 'B', c: 'C'}
    set_col :boolean_col, :boolean, 'booleanサンプル'
    
    set_col :description, :text_area, 'お問い合わせ内容'
  end
end

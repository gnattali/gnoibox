class Gnoibox::InquiryMailer < ActionMailer::Base
  default from: "no-reply@gnoibox.com"

  def notice(inquiry, base_info)
    @inquiry = inquiry
    title = base_info.try(:site_name)
    mail(to: Gnoibox::Author.pluck(:email), subject: "【#{title}】お問合せがありました")
  end
end

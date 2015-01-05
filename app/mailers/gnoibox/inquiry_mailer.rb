class Gnoibox::InquiryMailer < ActionMailer::Base
  default from: "no-reply@gnoibox.com"

  def notice(inquiry, base_info)
    @inquiry = inquiry
    title = base_info.try(:site_name)
    mail(to: Gnoibox::Author.admin.pluck(:email), subject: "【#{title}】お問合せがありました")
  end

  def thank_if_possible(inquiry, url_parser)
    if inquiry.inquirer_address
      @inquiry = inquiry
      mail(to: inquiry.inquirer_address, subject: inquiry.thanks_mail_subject(url_parser), template_name: inquiry.thanks_mail_view(url_parser) )
    end
  end
end

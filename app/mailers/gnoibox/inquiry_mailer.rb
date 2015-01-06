class Gnoibox::InquiryMailer < ActionMailer::Base
  default from: "no-reply@gnoibox.com"

  def notice(inquiry, url_parser)
    @inquiry = inquiry
    @url_parser = url_parser
    title = Gnoibox::BlockCollection::load(:base_info).try(:site_name)
    mail(to: Gnoibox::Author.admin.pluck(:email), subject: inquiry.notice_mail_subject(url_parser), template_name: inquiry.notice_mail_view(url_parser))
  end

  def thank_if_possible(inquiry, url_parser)
    if inquiry.inquirer_email.present?
      @inquiry = inquiry
      @url_parser = url_parser
      mail(to: inquiry.inquirer_email, subject: inquiry.thanks_mail_subject(url_parser), template_name: inquiry.thanks_mail_view(url_parser) )
    end
  end
end

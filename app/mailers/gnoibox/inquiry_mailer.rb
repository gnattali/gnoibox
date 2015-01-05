class Gnoibox::InquiryMailer < ActionMailer::Base
  default from: "no-reply@gnoibox.com"

  def notice(inquiry, base_info)
    @inquiry = inquiry
    title = base_info.try(:site_name)
    mail(to: Gnoibox::Author.admin.pluck(:email), subject: "【#{title}】お問合せがありました")
  end

  def thank_if_possible(inquiry, base_info)
    if inquiry.inquirer_address
      @inquiry = inquiry
      title = base_info.try(:site_name)
      mail(to: inquiry.inquirer_address, subject: "【#{title}】お問合せありがとうございます")
    end
  end
end
